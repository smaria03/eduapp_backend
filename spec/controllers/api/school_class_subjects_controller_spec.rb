require 'rails_helper'

describe 'SchoolClassSubjects API', type: :request do
  let!(:admin) { create(:user, :admin, password: 'admin123') }
  let!(:teacher) { create(:user, :teacher) }
  let!(:student) { create(:user, :student) }

  let!(:school_class) { create(:school_class) }
  let!(:subject) { create(:subject) }
  let!(:assignment) { SchoolClassSubject.create!(school_class: school_class, subject: subject) }

  before do
    post '/api/login', params: { email: admin.email, password: 'admin123', role: 'admin' }
    @admin_token = response.parsed_body['user']['token']
  end

  describe 'PATCH /api/school_class_subjects/:id' do
    it 'assigns a teacher to the class-subject' do
      patch "/api/school_class_subjects/#{assignment.id}",
            headers: { 'Authorization' => "Bearer #{@admin_token}" },
            params: { teacher_id: teacher.id }

      expect(response).to have_http_status(:ok)
      expect(assignment.reload.teacher_id).to eq(teacher.id)
    end

    it 'rejects when provided user is not a teacher' do
      patch "/api/school_class_subjects/#{assignment.id}",
            headers: { 'Authorization' => "Bearer #{@admin_token}" },
            params: { teacher_id: school_class.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(assignment.reload.teacher_id).to be_nil
    end
  end
end
