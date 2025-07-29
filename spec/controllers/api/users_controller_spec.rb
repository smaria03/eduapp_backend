# frozen_string_literal: true

require 'rails_helper'
require_relative '../../../app/controllers/api/users_controller'
describe Api::UsersController, type: :controller do
  describe 'POST #login' do
    let!(:student) do
      create(:user, email: 'student@example.com', password: 'password123', role: 'student')
    end
    let!(:teacher) do
      create(:user, email: 'teacher@example.com', password: 'password123', role: 'teacher')
    end

    it 'returns token for correct student credentials' do
      post :login,
           params: { email: 'student@example.com', password: 'password123', role: 'student' }

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['user']['token']).to be_present
    end

    it 'returns token for correct teacher credentials' do
      post :login,
           params: { email: 'teacher@example.com', password: 'password123', role: 'teacher' }

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['user']['token']).to be_present
    end

    it 'returns 401 for invalid password' do
      post :login, params: { email: 'teacher@example.com', password: 'wrongpass', role: 'teacher' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns 401 for invalid role' do
      post :login, params: { email: 'teacher@example.com', password: 'password123', role: 'admin' }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
