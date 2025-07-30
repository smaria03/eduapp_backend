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
        schema type: :object,
               properties: {
                 user: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     role: { type: :string },
                     email: { type: :string },
                     token: { type: :string }
                   },
                   required: ['id', 'name', 'role', 'email', 'token']
                 }
               },
               required: ['user']

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