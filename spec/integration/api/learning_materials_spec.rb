require 'swagger_helper'

RSpec.describe 'api/learning_materials', type: :request do
  let(:teacher) { create(:user, :teacher) }
  let(:student) { create(:user, :student) }
  let(:subject_rec) { create(:subject) }
  let(:school_class) { create(:school_class) }
  let(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject_rec,
                                  teacher: teacher)
  end

  let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }

  before do
    assignment
    student.update!(school_class: school_class)
  end

  path '/api/learning_materials' do
    get 'List teacher’s learning materials' do
      tags ['Learning Materials']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :assignment_id, in: :query, type: :integer, required: false

      response '200', 'Materials retrieved for current teacher' do
        let!(:material) do
          create(:learning_material, title: 'PDF 1', assignment: assignment).tap do |m|
            m.file.attach(
              io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
              filename: 'sample.pdf', content_type: 'application/pdf'
            )
          end
        end

        example 'application/json', :example, [
          {
            id: 1,
            title: 'PDF 1',
            desc: nil,
            uploaded_at: '2025-08-21T10:00:00Z',
            assignment_id: 1,
            file_url: 'http://localhost:3000/rails/active_storage/blobs/xyz...'
          }
        ]

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end

      response '401', 'Unauthorized (non-teacher)' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :student))}" }

        example 'application/json', :example, {
          error: 'Unauthorized: Teachers only'
        }

        run_test!
      end
    end

    post 'Upload a material (only if teacher owns assignment)' do
      tags ['Learning Materials']
      consumes 'multipart/form-data'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :title, in: :formData, type: :string
      parameter name: :desc, in: :formData, type: :string
      parameter name: :assignment_id, in: :formData, type: :integer
      parameter name: :file, in: :formData, type: :file

      response '201', 'Material uploaded successfully' do
        let(:title) { 'Lesson 1' }
        let(:desc) { 'Intro material' }
        let(:assignment_id) { assignment.id }
        let(:file) do
          fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf')
        end

        example 'application/json', :example, {
          message: 'Material uploaded successfully',
          material: {
            id: 1,
            title: 'Lesson 1',
            desc: 'Intro material',
            assignment_id: 1,
            created_at: '2025-08-21T08:30:45.034Z',
            updated_at: '2025-08-21T08:30:45.116Z'
          }
        }

        run_test!
      end

      response '401', 'Unauthorized if not teacher of assignment' do
        let(:assignment_id) { create(:school_class_subject).id }
        let(:title) { 'Hacked' }
        let(:desc) { 'Unauthorized attempt' }
        let(:file) do
          fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf')
        end

        example 'application/json', :example, {
          error: 'Not authorized to upload materials for this assignment'
        }

        run_test!
      end
    end
  end

  path '/api/learning_materials/{id}' do
    parameter name: :id, in: :path, type: :integer

    delete 'Delete a material (only by owning teacher)' do
      tags ['Learning Materials']
      security [bearer_auth: []]
      produces 'application/json'

      let!(:material) do
        create(:learning_material, assignment: assignment).tap do |m|
          m.file.attach(io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
                        filename: 'sample.pdf', content_type: 'application/pdf')
        end
      end
      let(:id) { material.id }

      response '200', 'Material deleted successfully' do
        example 'application/json', :example, {
          message: 'Material deleted successfully'
        }

        run_test!
      end

      response '401', 'Unauthorized if not owning teacher' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :teacher))}" }

        example 'application/json', :example, {
          error: 'Not authorized to delete this material'
        }

        run_test!
      end
    end
  end
end
