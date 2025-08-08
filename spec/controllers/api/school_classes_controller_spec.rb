require 'rails_helper'

describe 'Admin::SchoolClasses API', type: :request do
  let!(:admin) { create(:user, :admin, password: 'admin123') }
  let!(:student1) { create(:user, :student) }
  let!(:student2) { create(:user, :student) }
  let!(:student3) { create(:user, :student) }

  before do
    post '/api/login', params: { email: admin.email, password: 'admin123', role: 'admin' }
    @admin_token = response.parsed_body['user']['token']
  end

  describe 'POST /api/school_classes' do
    it 'creates a class with valid students' do
      expect do
        post '/api/school_classes',
             headers: { 'Authorization' => "Bearer #{@admin_token}" },
             params: {
               school_class: {
                 name: '10A',
                 student_ids: [student1.id, student2.id]
               }
             }
      end.to change(SchoolClass, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.parsed_body['name']).to eq('10A')
    end

    it 'fails if class name is duplicate' do
      create(:school_class, name: '10A')
      post '/api/school_classes',
           headers: { 'Authorization' => "Bearer #{@admin_token}" },
           params: { school_class: { name: '10A', student_ids: [] }}

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'fails if students are already assigned to other classes' do
      existing_class = create(:school_class, name: '9C')
      student1.update(school_class: existing_class)

      post '/api/school_classes',
           headers: { 'Authorization' => "Bearer #{@admin_token}" },
           params: { school_class: { name: '11B', student_ids: [student1.id] }}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body['students'].first['id']).to eq(student1.id)
    end
  end

  describe 'PATCH /api/school_classes/:id' do
    let!(:school_class) { create(:school_class, name: '10A') }

    it 'updates name and student list' do
      patch "/api/school_classes/#{school_class.id}",
            headers: { 'Authorization' => "Bearer #{@admin_token}" },
            params: { school_class: { name: '10B', student_ids: [student3.id] }}

      expect(response).to have_http_status(:ok)
      expect(school_class.reload.name).to eq('10B')
      expect(school_class.students).to include(student3)
    end
  end

  describe 'POST /api/school_classes/:id/add_student/:student_id' do
    let!(:school_class) { create(:school_class, name: '12A') }

    it 'adds a new student to class' do
      post "/api/school_classes/#{school_class.id}/add_student/#{student1.id}",
           headers: { 'Authorization' => "Bearer #{@admin_token}" }

      expect(response).to have_http_status(:ok)
      expect(student1.reload.school_class_id).to eq(school_class.id)
    end

    it 'returns error if student already assigned' do
      other_class = create(:school_class, name: '8B')
      student2.update(school_class: other_class)

      post "/api/school_classes/#{school_class.id}/add_student/#{student2.id}",
           headers: { 'Authorization' => "Bearer #{@admin_token}" }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE /api/school_classes/:id/remove_student/:student_id' do
    let!(:school_class) { create(:school_class, name: '5A') }

    before { student3.update(school_class: school_class) }

    it 'removes a student from the class' do
      delete "/api/school_classes/#{school_class.id}/remove_student/#{student3.id}",
             headers: { 'Authorization' => "Bearer #{@admin_token}" }

      expect(response).to have_http_status(:ok)
      expect(student3.reload.school_class_id).to be_nil
    end
  end

  describe 'DELETE /api/school_classes/:id' do
    let!(:school_class) { create(:school_class, name: '11A') }

    it 'deletes the class successfully' do
      expect do
        delete "/api/school_classes/#{school_class.id}",
               headers: { 'Authorization' => "Bearer #{@admin_token}" }
      end.to change(SchoolClass, :count).by(-1)

      expect(response).to have_http_status(:ok).or have_http_status(:no_content)
    end
  end
end
