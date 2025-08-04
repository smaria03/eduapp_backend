require 'swagger_helper'

RSpec.describe 'Authentication', type: :request do
  path '/api/login' do
    post 'User login' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'
      security []

      parameter name: :credentials, in: :body, required: true, schema: {
        type: :object,
        properties: {
          email: {
            type: :string,
            description: "User's email address",
            example: 'teacher1@example.com'
          },
          password: {
            type: :string,
            description: "User's password",
            example: '123456'
          }
        },
        required: %w[email password]
      }

      response '200', 'successful login' do
        let!(:user) do
          User.create!(
            email: 'teacher1@example.com',
            password: '123456',
            role: 'teacher',
            name: 'Prenume1 Nume1'
          )
        end

        let(:credentials) do
          {
            email: 'teacher1@example.com',
            password: '123456'
          }
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              user: {
                id: 1,
                name: 'Prenume1 Nume1',
                email: 'teacher1@example.com',
                role: 'teacher',
                token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'
              }
            }
          }
        }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:credentials) do
          {
            email: 'teacher1@example.com',
            password: 'wrongpass'
          }
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              errors: ['Invalid email/password combination']
            }
          }
        }

        run_test!
      end
    end
  end
end
