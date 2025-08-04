require 'swagger_helper'

RSpec.describe 'api/admin/users', type: :request do
  path '/api/admin/users' do
    post 'Create a new user (admin only)' do
      tags ['Admin Users']
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

        before do
          allow_any_instance_of(Api::Admin::UsersController)
            .to receive(:current_user).and_return(admin)
          allow_any_instance_of(Api::Admin::UsersController)
            .to receive(:authenticate_user!).and_return(true)
        end

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

        before do
          allow_any_instance_of(Api::Admin::UsersController)
            .to receive(:current_user).and_return(admin)
          allow_any_instance_of(Api::Admin::UsersController)
            .to receive(:authenticate_user!).and_return(true)
        end

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

        before do
          allow_any_instance_of(Api::Admin::UsersController)
            .to receive(:current_user).and_return(student)
          allow_any_instance_of(Api::Admin::UsersController)
            .to receive(:authenticate_user!).and_return(true)
        end

        run_test!
      end
    end
  end
end
