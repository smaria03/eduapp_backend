require 'swagger_helper'

RSpec.describe 'Authentication', type: :request do
  path '/api/login' do
    post 'User login' do
      tags 'Authentication'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          role: { type: :string }
        },
        required: ['email', 'password', 'role']
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
            password: '123456',
            role: 'teacher'
          }
        end

        run_test!
      end

      response '401', 'unauthorized' do
        let(:credentials) do
          {
            email: 'teacher1@example.com',
            password: 'wrongpass',
            role: 'teacher'
          }
        end

        run_test!
      end
    end
  end
end