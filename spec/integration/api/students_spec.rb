require 'swagger_helper'

RSpec.describe 'api/students', type: :request do
  path '/api/students' do
    get 'Get list of all students' do
      tags ['Users']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'students retrieved successfully' do
        let!(:admin) { create(:user, role: 'admin') }

        let!(:students) do
          [
            create(:user, role: 'student', name: 'Prenume1 Nume1', email: 'student1@example.com'),
            create(:user, role: 'student', name: 'Prenume2 Nume2', email: 'student2@example.com')
          ]
        end

        let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

        metadata[:response][:content] = {
          'application/json' => {
            example: [
              {
                id: 1,
                name: 'Prenume1 Nume1',
                email: 'student1@example.com',
                role: 'student'
              },
              {
                id: 2,
                name: 'Prenume2 Nume2',
                email: 'student2@example.com',
                role: 'student'
              }
            ]
          }
        }

        run_test!
      end

      response '401', 'unauthorized (no token)' do
        let(:Authorization) { nil }

        run_test!
      end
    end
  end
end

def generate_token_for(user)
  Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
end
