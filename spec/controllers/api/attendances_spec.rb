require 'rails_helper'

describe 'Attendances API', type: :request do
  let!(:teacher)  { create(:user, :teacher, password: 'teacher123') }
  let!(:student)  { create(:user, :student) }
  let!(:subject)  { create(:subject) }
  let!(:school_class) { create(:school_class) }
  let!(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject, teacher: teacher)
  end
  let!(:period) { create(:period) }
  let(:date) { Date.parse('2025-09-09') }

  before do
    student.update!(school_class: school_class)
    create(:timetable_entry, assignment: assignment, period: period, weekday: :tuesday)
    post '/api/login', params: { email: teacher.email, password: 'teacher123', role: 'teacher' }
    @teacher_token = response.parsed_body['user']['token']
  end

  describe 'POST /api/attendances' do
    it 'creates an attendance when assignment is scheduled and student belongs to the class' do
      expect do
        post '/api/attendances',
             headers: { 'Authorization' => "Bearer #{@teacher_token}" },
             params: {
               attendance: {
                 user_id: student.id,
                 assignment_id: assignment.id,
                 period_id: period.id,
                 date: date.to_s,
                 status: 'present'
               }
             }
      end.to change(Attendance, :count).by(1)

      expect(response).to have_http_status(:created)
      body = response.parsed_body
      expect(body['attendance']['user_id']).to eq(student.id)
      expect(body['attendance']['assignment_id']).to eq(assignment.id)
      expect(body['attendance']['period_id']).to eq(period.id)
      expect(body['attendance']['date']).to eq(date.to_s)
      expect(body['attendance']['status']).to eq('present')
    end

    it 'fails with 422 if there is no scheduled class in timetable for given date/period' do
      TimetableEntry.where(assignment_id: assignment.id, period_id: period.id,
                           weekday: 2).delete_all

      post '/api/attendances',
           headers: { 'Authorization' => "Bearer #{@teacher_token}" },
           params: {
             attendance: {
               user_id: student.id,
               assignment_id: assignment.id,
               period_id: period.id,
               date: date.to_s,
               status: 'absent'
             }
           }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']).to include(
        'No scheduled class for this assignment and period on the given date'
      )
    end

    it 'fails with 422 if the student does not belong to the assignment class' do
      other_class = create(:school_class)
      student.update!(school_class: other_class)

      post '/api/attendances',
           headers: { 'Authorization' => "Bearer #{@teacher_token}" },
           params: {
             attendance: {
               user_id: student.id,
               assignment_id: assignment.id,
               period_id: period.id,
               date: date.to_s,
               status: 'present'
             }
           }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']).to include(
        "User does not belong to the assignment's class"
      )
    end

    it 'fails with 422 on duplicate attendance (same user, assignment, period, date)' do
      create(:attendance, user: student, assignment: assignment, period: period, date: date,
                          status: :present)

      post '/api/attendances',
           headers: { 'Authorization' => "Bearer #{@teacher_token}" },
           params: {
             attendance: {
               user_id: student.id,
               assignment_id: assignment.id,
               period_id: period.id,
               date: date.to_s,
               status: 'absent'
             }
           }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['errors']).to include(
        'User already has attendance recorded for this class/period/date'
      )
    end
  end

  describe 'GET /api/attendances' do
    let!(:att1) do
      create(:attendance, user: student, assignment: assignment, period: period, date: date,
                          status: :present)
    end
    let!(:att2) do
      create(:timetable_entry, assignment: assignment, period: period, weekday: :wednesday)
      create(:attendance, user: student, assignment: assignment, period: period, date: date + 1,
                          status: :absent)
    end
    let!(:other_assignment) do
      create(:school_class_subject, school_class: school_class, subject: create(:subject),
                                    teacher: teacher)
    end
    let(:other_date) { Date.parse('2025-09-10') }
    let(:other_period) { create(:period, start_time: '10:00', end_time: '10:50') }

    before do
      create(:timetable_entry, assignment: other_assignment, period: other_period,
                               weekday: other_date.wday)
    end

    let!(:att_other) do
      create(:attendance, user: student, assignment: other_assignment, period: other_period,
                          date: other_date, status: :present)
    end

    it 'returns attendances filtered by assignment_id and date' do
      get "/api/attendances?assignment_id=#{assignment.id}&date=#{date}", headers: { 'Authorization' => "Bearer #{@teacher_token}" }

      expect(response).to have_http_status(:ok)
      list = response.parsed_body
      expect(list).to be_an(Array)
      ids = list.map { |a| a['id'] }
      expect(ids).to include(att1.id)
      expect(ids).not_to include(att2.id)
      expect(ids).not_to include(att_other.id)
    end

    it 'returns attendances filtered by user_id' do
      get "/api/attendances?user_id=#{student.id}", headers: { 'Authorization' => "Bearer #{@teacher_token}" }

      expect(response).to have_http_status(:ok)
      list = response.parsed_body
      expect(list).to all(satisfy { |a| a['user_id'] == student.id })
    end
  end

  describe 'DELETE /api/attendances/:id' do
    let!(:attendance) do
      create(:attendance, user: student, assignment: assignment, period: period, date: date,
                          status: :present)
    end

    it 'deletes the attendance when teacher owns the assignment' do
      expect do
        delete "/api/attendances/#{attendance.id}", headers: { 'Authorization' => "Bearer #{@teacher_token}" }
      end.to change(Attendance, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it 'returns 403 when another teacher tries to delete' do
      other_teacher = create(:user, :teacher, password: 'other123')
      post '/api/login',
           params: { email: other_teacher.email, password: 'other123', role: 'teacher' }
      other_token = response.parsed_body['user']['token']

      delete "/api/attendances/#{attendance.id}", headers: { 'Authorization' => "Bearer #{other_token}" }

      expect(response).to have_http_status(:forbidden)
      expect(response.parsed_body['error']).to eq('Not authorized to delete this attendance')
    end

    it 'returns 404 when attendance is missing' do
      delete '/api/attendances/999999', headers: { 'Authorization' => "Bearer #{@teacher_token}" }

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Attendance not found')
    end
  end
end
