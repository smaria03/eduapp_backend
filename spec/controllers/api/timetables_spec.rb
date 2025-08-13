require 'rails_helper'

describe 'Timetable API', type: :request do
  let!(:admin)   { create(:user, :admin,   password: 'admin123') }
  let!(:teacher) { create(:user, :teacher, password: 'teach123') }
  let!(:teacher2) { create(:user, :teacher) }
  let!(:student) { create(:user, :student) }

  let!(:class_a) { create(:school_class, name: '9A') }
  let!(:class_b) { create(:school_class, name: '9B') }

  let!(:subject_math) { create(:subject, name: 'Math') }
  let!(:subject_rom)  { create(:subject, name: 'Romanian') }

  let!(:assignment_a_math) do
    SchoolClassSubject.create!(school_class: class_a, subject: subject_math, teacher: teacher)
  end
  let!(:assignment_a_rom) do
    SchoolClassSubject.create!(school_class: class_a, subject: subject_rom, teacher: teacher2)
  end
  let!(:assignment_b_math) do
    SchoolClassSubject.create!(school_class: class_b, subject: subject_math, teacher: teacher)
  end

  let!(:period1) { Period.create!(start_time: '08:00', end_time: '08:50') }
  let!(:period2) { Period.create!(start_time: '09:00', end_time: '09:50') }

  before do
    student.update!(school_class: class_a)

    post '/api/login', params: { email: admin.email, password: 'admin123', role: 'admin' }
    @admin_token = response.parsed_body['user']['token']
  end

  describe 'GET /api/timetable' do
    it 'returns only the current teacher timetable for teachers' do
      TimetableEntry.create!(assignment: assignment_a_math, weekday: 1, period: period1)
      TimetableEntry.create!(assignment: assignment_a_rom,  weekday: 1, period: period2)

      post '/api/login', params: { email: teacher.email, password: 'teach123', role: 'teacher' }
      teacher_token = response.parsed_body['user']['token']

      get '/api/timetable', headers: { 'Authorization' => "Bearer #{teacher_token}" }
      expect(response).to have_http_status(:ok)

      data = response.parsed_body
      expect(data.size).to eq(1)
      expect(data.first['teacher_id']).to eq(teacher.id)
    end

    it 'returns only the current student class timetable for students' do
      TimetableEntry.create!(assignment: assignment_a_math, weekday: 2, period: period1)
      TimetableEntry.create!(assignment: assignment_b_math, weekday: 2, period: period2)

      post '/api/login',
           params: { email: student.email, password: student.password || 'password',
                     role: 'student' }
      student_token = response.parsed_body['user']['token']

      get '/api/timetable', headers: { 'Authorization' => "Bearer #{student_token}" }
      expect(response).to have_http_status(:ok)

      data = response.parsed_body
      expect(data.size).to eq(1)
      expect(data.first['class_id']).to eq(class_a.id)
    end

    it 'allows admin to see all and filter by class_id' do
      e1 = TimetableEntry.create!(assignment: assignment_a_math, weekday: 3, period: period1)
      _e2 = TimetableEntry.create!(assignment: assignment_b_math, weekday: 3, period: period2)

      get '/api/timetable',
          params: { class_id: class_a.id },
          headers: { 'Authorization' => "Bearer #{@admin_token}" }

      expect(response).to have_http_status(:ok)
      ids = response.parsed_body.map { |h| h['id'] }
      expect(ids).to eq([e1.id])
    end
  end

  describe 'POST /api/timetable' do
    it 'creates a timetable entry as admin' do
      payload = {
        timetable_entry: { assignment_id: assignment_a_math.id, weekday: 1, period_id: period1.id }
      }

      post '/api/timetable',
           headers: { 'Authorization' => "Bearer #{@admin_token}", 'Content-Type' => 'application/json' },
           params: payload.to_json

      expect(response).to have_http_status(:created)
      body = response.parsed_body
      expect(body['assignment_id']).to eq(assignment_a_math.id)
      expect(body['weekday']).to eq('monday')
    end

    it 'rejects non-admin users' do
      post '/api/login', params: { email: teacher.email, password: 'teach123', role: 'teacher' }
      teacher_token = response.parsed_body['user']['token']

      payload = {
        timetable_entry: { assignment_id: assignment_a_math.id, weekday: 1, period_id: period1.id }
      }

      post '/api/timetable',
           headers: { 'Authorization' => "Bearer #{teacher_token}", 'Content-Type' => 'application/json' },
           params: payload.to_json

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 422 when the class already has a lesson in the same slot' do
      TimetableEntry.create!(assignment: assignment_a_math, weekday: 1, period: period1)

      payload = { timetable_entry: { assignment_id: assignment_a_rom.id, weekday: 1,
                                     period_id: period1.id }}

      post '/api/timetable',
           headers: { 'Authorization' => "Bearer #{@admin_token}", 'Content-Type' => 'application/json' },
           params: payload.to_json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors'].join).to match(/class.*slot/i)
    end

    it 'returns 422 when the teacher already has a lesson in the same slot' do
      TimetableEntry.create!(assignment: assignment_a_math, weekday: 1, period: period1)

      payload = { timetable_entry: { assignment_id: assignment_b_math.id, weekday: 1,
                                     period_id: period1.id }}

      post '/api/timetable',
           headers: { 'Authorization' => "Bearer #{@admin_token}", 'Content-Type' => 'application/json' },
           params: payload.to_json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors'].join).to match(/Teacher.*slot/i)
    end
  end

  describe 'PATCH /api/timetable/:id' do
    it 'updates an entry as admin' do
      entry = TimetableEntry.create!(assignment: assignment_a_math, weekday: 4, period: period1)

      patch "/api/timetable/#{entry.id}",
            headers: { 'Authorization' => "Bearer #{@admin_token}", 'Content-Type' => 'application/json' },
            params: { timetable_entry: { weekday: 5, period_id: period2.id }}.to_json

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['weekday']).to eq('friday')
    end

    it 'rejects non-admin users' do
      entry = TimetableEntry.create!(assignment: assignment_a_math, weekday: 3, period: period1)

      post '/api/login',
           params: { email: student.email, password: student.password || 'password',
                     role: 'student' }
      st_token = response.parsed_body['user']['token']

      patch "/api/timetable/#{entry.id}",
            headers: { 'Authorization' => "Bearer #{st_token}", 'Content-Type' => 'application/json' },
            params: { timetable_entry: { weekday: 2 }}.to_json

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'DELETE /api/timetable/:id' do
    it 'deletes an entry as admin' do
      entry = TimetableEntry.create!(assignment: assignment_a_math, weekday: 1, period: period2)

      delete "/api/timetable/#{entry.id}",
             headers: { 'Authorization' => "Bearer #{@admin_token}" }

      expect(response).to have_http_status(:no_content)
      expect { entry.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'rejects non-admin users' do
      entry = TimetableEntry.create!(assignment: assignment_a_math, weekday: 2, period: period2)

      post '/api/login', params: { email: teacher.email, password: 'teach123', role: 'teacher' }
      t_token = response.parsed_body['user']['token']

      delete "/api/timetable/#{entry.id}",
             headers: { 'Authorization' => "Bearer #{t_token}" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
