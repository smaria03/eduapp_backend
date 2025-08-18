require 'rails_helper'

describe 'Grades API', type: :request do
  let!(:teacher) { create(:user, :teacher, password: 'teacher123') }
  let!(:student) { create(:user, :student) }
  let!(:subject) { create(:subject) }
  let!(:school_class) { create(:school_class) }
  let!(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject, teacher: teacher)
  end

  before do
    student.update!(school_class: school_class)

    post '/api/login', params: { email: teacher.email, password: 'teacher123', role: 'teacher' }
    @teacher_token = response.parsed_body['user']['token']
  end

  describe 'POST /api/grades' do
    it 'creates a grade if teacher is assigned to subject for student’s class' do
      expect do
        post '/api/grades',
             headers: { 'Authorization' => "Bearer #{@teacher_token}" },
             params: {
               grade: {
                 value: 9,
                 student_id: student.id,
                 subject_id: subject.id
               }
             }
      end.to change(Grade, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.parsed_body['grade']['value']).to eq(9)
    end

    it 'fails if teacher is not assigned to subject for that class' do
      assignment.destroy

      post '/api/grades',
           headers: { 'Authorization' => "Bearer #{@teacher_token}" },
           params: {
             grade: {
               value: 7,
               student_id: student.id,
               subject_id: subject.id
             }
           }

      expect(response).to have_http_status(:forbidden)
      expect(response.parsed_body['error']).to eq(
        'Unauthorized: You are not assigned to this subject for this class'
      )
    end

    it 'fails if student is not part of the assigned class' do
      other_class = create(:school_class)
      student.update!(school_class: other_class)

      post '/api/grades',
           headers: { 'Authorization' => "Bearer #{@teacher_token}" },
           params: {
             grade: {
               value: 7,
               student_id: student.id,
               subject_id: subject.id
             }
           }

      expect(response).to have_http_status(:forbidden)
      expect(response.parsed_body['error']).to eq(
        'Unauthorized: You are not assigned to this subject for this class'
      )
    end
  end

  describe 'GET /api/grades' do
    let!(:grade1) { create(:grade, value: 8, student: student, subject: subject, teacher: teacher) }

    it 'returns only grades created by the logged in teacher' do
      get '/api/grades', headers: { 'Authorization' => "Bearer #{@teacher_token}" }

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to be_an(Array)
      expect(response.parsed_body.first['teacher_id']).to eq(teacher.id)
    end
  end

  describe 'PATCH /api/grades/:id' do
    let!(:grade) { create(:grade, value: 6, student: student, subject: subject, teacher: teacher) }

    it 'updates the grade value' do
      patch "/api/grades/#{grade.id}",
            headers: { 'Authorization' => "Bearer #{@teacher_token}" },
            params: { grade: { value: 10 }}

      expect(response).to have_http_status(:ok)
      expect(grade.reload.value).to eq(10)
    end
  end

  describe 'DELETE /api/grades/:id' do
    let!(:grade) { create(:grade, value: 4, student: student, subject: subject, teacher: teacher) }

    it 'deletes the grade' do
      expect do
        delete "/api/grades/#{grade.id}",
               headers: { 'Authorization' => "Bearer #{@teacher_token}" }
      end.to change(Grade, :count).by(-1)

      expect(response).to have_http_status(:no_content).or have_http_status(:ok)
    end
  end
end
