require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users' do
    post 'Create a new user (admin only)' do
      tags ['Users']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :user, in: :body, required: true, schema: {
        type: :object,
        required: ['user'],
        properties: {
          user: {
            type: :object,
            required: %w[email password password_confirmation name role],
            properties: {
              email: { type: :string, example: 'student3@example.com' },
              password: { type: :string, example: '123456' },
              password_confirmation: { type: :string, example: '123456' },
              name: { type: :string, example: 'Prenume3 Nume3' },
              role: { type: :string, enum: %w[student teacher], example: 'student' }
            }
          }
        }
      }

      response '201', 'user created' do
        let!(:admin) { create(:user, role: 'admin') }

        let(:user) do
          {
            user: {
              email: 'student3@example.com',
              password: '123456',
              password_confirmation: '123456',
              name: 'Prenume3 Nume3',
              role: 'student'
            }
          }
        end

        let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              id: 123,
              email: 'student3@example.com',
              name: 'Prenume3 Nume3',
              role: 'student'
            }
          }
        }

        run_test!
      end

      response '422', 'invalid request' do
        let!(:admin) { create(:user, role: 'admin') }

        let(:user) do
          {
            user: {
              email: '',
              password: '123',
              password_confirmation: '456',
              name: '',
              role: 'invalid'
            }
          }
        end

        let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              errors: [
                "Email can't be blank",
                "Name can't be blank",
                'Password is too short',
                "Password confirmation doesn't match Password",
                'Role is not included in the list'
              ]
            }
          }
        }

        run_test!
      end

      response '401', 'unauthorized' do
        let!(:student) { create(:user, role: 'student') }

        let(:user) do
          {
            user: {
              email: 'unauth@example.com',
              password: '123456',
              password_confirmation: '123456',
              name: 'Unauthorized',
              role: 'student'
            }
          }
        end

        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              error: 'Access denied: admin only'
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
