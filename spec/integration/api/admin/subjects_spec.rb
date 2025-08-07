require 'swagger_helper'

RSpec.describe 'api/admin/subjects', type: :request do
  let(:admin) { create(:user, role: 'admin') }
  let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

  path '/api/admin/subjects' do
    post 'Create a new subject (admin only)' do
      tags ['Admin Subjects']
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

    get 'List all subjects (admin only)' do
      tags ['Admin Subjects']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'subjects listed' do
        let!(:_subjects) { create_list(:subject, 2) }

        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string }
          },
          required: %w[id name]
        }

        metadata[:response][:content] = {
          'application/json' => {
            example: [
              { id: 1, name: 'Math' },
              { id: 2, name: 'Geography' }
            ]
          }
        }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:student) { create(:user, role: 'student') }
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

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

  path '/api/admin/subjects/{id}' do
    parameter name: :id, in: :path, type: :string, required: true, description: 'Subject ID'

    delete 'Delete a subject (admin only)' do
      tags ['Admin Subjects']
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
