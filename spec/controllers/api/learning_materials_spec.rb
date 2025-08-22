require 'rails_helper'

describe 'LearningMaterials API', type: :request do
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

  describe 'POST /api/learning_materials' do
    it 'uploads a material if teacher owns the assignment' do
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'),
                                 'application/pdf')

      expect do
        post '/api/learning_materials',
             headers: { 'Authorization' => "Bearer #{@teacher_token}" },
             params: {
               title: 'Lesson 1',
               description: 'Intro',
               assignment_id: assignment.id,
               file: file
             }
      end.to change(LearningMaterial, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(response.parsed_body['material']['title']).to eq('Lesson 1')
    end

    it 'rejects upload if teacher does not own assignment' do
      other_assignment = create(:school_class_subject)
      file = fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'),
                                 'application/pdf')

      post '/api/learning_materials',
           headers: { 'Authorization' => "Bearer #{@teacher_token}" },
           params: {
             title: 'Unauthorized',
             assignment_id: other_assignment.id,
             file: file
           }

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body['error']).to eq(
        'Not authorized to upload materials for this assignment'
      )
    end
  end

  describe 'GET /api/learning_materials' do
    let!(:material1) do
      material = build(:learning_material, assignment: assignment, title: 'Material A')
      material.file.attach(
        io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
        filename: 'sample.pdf',
        content_type: 'application/pdf'
      )
      material.save!
    end

    it 'returns only materials uploaded for teacher’s assignments' do
      get '/api/learning_materials', headers: { 'Authorization' => "Bearer #{@teacher_token}" }

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to be_an(Array)
      expect(response.parsed_body.first['title']).to eq('Material A')
    end

    it 'filters materials by assignment_id' do
      get "/api/learning_materials?assignment_id=#{assignment.id}",
          headers: { 'Authorization' => "Bearer #{@teacher_token}" }

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.length).to eq(1)
    end
  end

  describe 'DELETE /api/learning_materials/:id' do
    let!(:material) do
      m = build(:learning_material, assignment: assignment, title: 'To delete')
      m.file.attach(
        io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
        filename: 'sample.pdf',
        content_type: 'application/pdf'
      )
      m.save!
      m
    end

    it 'allows deletion if teacher owns assignment' do
      expect do
        delete "/api/learning_materials/#{material.id}",
               headers: { 'Authorization' => "Bearer #{@teacher_token}" }
      end.to change(LearningMaterial, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end

    it 'rejects deletion if teacher does not own assignment' do
      other_teacher = create(:user, :teacher)
      material.assignment.update!(teacher: other_teacher)

      delete "/api/learning_materials/#{material.id}",
             headers: { 'Authorization' => "Bearer #{@teacher_token}" }

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body['error']).to eq('Not authorized to delete this material')
    end
  end
end
