require 'swagger_helper'

RSpec.describe 'api/teachers', type: :request do
  path '/api/teachers' do
    get 'Get list of all teachers' do
      tags ['Users']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'teachers retrieved successfully' do
        let!(:admin) { create(:user, role: 'admin') }

        let!(:teachers) do
          [
            create(:user, role: 'teacher', name: 'Prenume1 Nume1', email: 'teacher1@example.com'),
            create(:user, role: 'teacher', name: 'Prenume2 Nume2', email: 'teacher2@example.com')
          ]
        end

        let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

        metadata[:response][:content] = {
          'application/json' => {
            example: [
              {
                id: 1,
                name: 'Prenume1 Nume1',
                email: 'teacher1@example.com',
                role: 'teacher'
              },
              {
                id: 2,
                name: 'Prenume2 Nume2',
                email: 'teacher2@example.com',
                role: 'teacher'
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
