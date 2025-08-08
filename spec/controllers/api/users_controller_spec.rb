# frozen_string_literal: true

require 'rails_helper'

describe 'Api::UsersController', type: :request do
  let!(:student) do
    create(:user, email: 'student@example.com', password: 'password123', role: 'student')
  end
  let!(:teacher) do
    create(:user, email: 'teacher@example.com', password: 'password123', role: 'teacher')
  end
  let!(:admin) { create(:user, :admin, email: 'admin@example.com', password: 'admin123') }

  describe 'POST /api/login' do
    context 'with valid credentials' do
      it 'returns a token for a student' do
        post '/api/login',
             params: { email: 'student@example.com', password: 'password123' }

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['user']['token']).to be_present
      end

      it 'returns a token for a teacher' do
        post '/api/login',
             params: { email: 'teacher@example.com', password: 'password123' }

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['user']['token']).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns 401 for an invalid password' do
        post '/api/login',
             params: { email: 'teacher@example.com', password: 'wrongpass' }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /api/users' do
    let(:admin_token) do
      post '/api/login', params: { email: admin.email, password: 'admin123' }
      response.parsed_body['user']['token']
    end

    let(:teacher_token) do
      post '/api/login', params: { email: teacher.email, password: 'password123' }
      response.parsed_body['user']['token']
    end

    context 'when requester is an admin' do
      it 'creates a new user if data is valid' do
        expect do
          post '/api/users',
               params: {
                 user: {
                   name: 'New Student',
                   email: 'studentnew@example.com',
                   password: 'pass123',
                   password_confirmation: 'pass123',
                   role: 'student'
                 }
               },
               headers: { 'Authorization' => "Bearer #{admin_token}" }
        end.to change(User, :count).by(1)

        expect(response).to have_http_status(:created)
      end

      it 'returns validation errors if data is invalid' do
        post '/api/users',
             params: {
               user: { name: '', email: '', password: '123' }
             },
             headers: { 'Authorization' => "Bearer #{admin_token}" }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['errors']).to be_present
      end
    end

    context 'when requester is NOT an admin' do
      it 'returns unauthorized and does not create the user' do
        expect do
          post '/api/users',
               params: {
                 user: { name: 'Invalid User', email: 'invalid@example.com', password: 'password' }
               },
               headers: { 'Authorization' => "Bearer #{teacher_token}" }
        end.not_to change(User, :count)

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when requester is not authenticated' do
      it 'returns unauthorized' do
        post '/api/users', params: { user: { name: 'Test' }}

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
