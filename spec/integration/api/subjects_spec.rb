require 'swagger_helper'

RSpec.describe 'api/subjects', type: :request do
  let(:admin) { create(:user, role: 'admin') }
  let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

  path '/api/subjects' do
    post 'Create a new subject (admin only)' do
      tags ['Subjects']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :subject, in: :body, required: true, schema: {
        type: :object,
        required: ['subject'],
        properties: {
          subject: {
            type: :object,
            required: ['name'],
            properties: {
              name: { type: :string, example: 'Mathematics' }
            }
          }
        }
      }

      response '201', 'subject created' do
        let(:subject) do
          {
            subject: {
              name: 'Mathematics'
            }
          }
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              id: 1,
              name: 'Mathematics'
            }
          }
        }

        run_test!
      end

      response '422', 'invalid request' do
        let(:subject) do
          {
            subject: {
              name: ''
            }
          }
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              errors: ["Name can't be blank"]
            }
          }
        }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:student) { create(:user, role: 'student') }
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        let(:subject) do
          {
            subject: {
              name: 'History'
            }
          }
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              error: 'Access denied'
            }
          }
        }

        run_test!
      end
    end

    get 'List all subjects' do
      tags ['Subjects']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :teacher_id, in: :query, type: :string, required: false,
                description: 'Filter subjects by teacher'

      response '200', 'subjects listed or filtered by teacher' do
        let(:teacher) { create(:user, role: 'teacher') }

        let!(:school_class_1) { create(:school_class, name: '9B') }
        let!(:school_class_2) { create(:school_class, name: '10A') }
        let!(:subject_1) { create(:subject, name: 'Math') }
        let!(:subject_2) { create(:subject, name: 'Physics') }

        let!(:scs_1) do
          create(:school_class_subject, teacher: teacher, subject: subject_1,
                                        school_class: school_class_1)
        end
        let!(:scs_2) do
          create(:school_class_subject, teacher: teacher, subject: subject_2,
                                        school_class: school_class_2)
        end

        let(:teacher_id) { teacher.id }

        schema anyOf: [
          {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string }
              },
              required: %w[id name]
            }
          },
          {
            type: :array,
            items: {
              type: :object,
              properties: {
                subject_name: { type: :string },
                class_name: { type: :string }
              },
              required: %w[subject_name class_name]
            }
          }
        ]

        metadata[:response][:content] = {
          'application/json' => {
            examples: {
              all_subjects: {
                summary: 'List of all subjects (admin or no teacher_id)',
                value: [
                  { id: 1, name: 'Math' },
                  { id: 2, name: 'Geography' }
                ]
              },
              teacher_subjects: {
                summary: 'Subjects taught by teacher (with teacher_id)',
                value: [
                  { subject_name: 'Math', class_name: '9B' },
                  { subject_name: 'Physics', class_name: '10A' }
                ]
              }
            }
          }
        }

        run_test!
      end

      response '404', 'invalid teacher id' do
        let(:teacher_id) { 99_999 }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              error: 'Teacher not found'
            }
          }
        }

        run_test!
      end
    end
  end

  path '/api/subjects/{id}' do
    parameter name: :id, in: :path, type: :string, required: true, description: 'Subject ID'

    delete 'Delete a subject (admin only)' do
      tags ['Subjects']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'subject deleted' do
        let!(:subject_record) { create(:subject, name: 'Math') }
        let(:id) { subject_record.id }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              message: 'Subject deleted successfully'
            }
          }
        }

        run_test!
      end

      response '404', 'subject not found' do
        let(:id) { '99999' }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              error: 'Subject not found'
            }
          }
        }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:student) { create(:user, role: 'student') }
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }
        let(:id) { '1' }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              error: 'Access denied'
            }
          }
        }

        run_test!
      end
    end
  end
end

def generate_token_for(user)
  Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
end
