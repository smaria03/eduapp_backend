require 'rails_helper'

describe Api::Admin::UsersController, type: :request do
  before :each do
    @admin = create(:user, name: 'Admin', email: 'admin@example.com', password: 'admin123',
                           role: 'admin')
    @teacher = create(:user, name: 'Teacher', email: 'teacher@example.com', password: 'teacher123',
                             role: 'teacher')

    post '/api/login', params: { email: @admin.email, password: 'admin123', role: 'admin' }
    @admin_token = response.parsed_body['user']['token']
  end

  describe 'POST /api/admin/users' do
    it 'creates a student if the requester is an authenticated admin' do
      expect do
        post '/api/admin/users',
             params: {
               user: {
                 name: 'New Student',
                 email: 'studentnew@example.com',
                 password: 'pass123',
                 password_confirmation: 'pass123',
                 role: 'student'
               }
             },
             headers: { 'Authorization' => "Bearer #{@admin_token}" }
      end.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
      json = response.parsed_body
      expect(json['user']['email']).to eq('studentnew@example.com')
    end

    it 'does not allow user creation if requester is not an admin' do
      post '/api/login', params: { email: @teacher.email, password: 'teacher123', role: 'teacher' }
      token = response.parsed_body['user']['token']

      post '/api/admin/users',
           params: {
             user: {
               name: 'Invalid',
               email: 'unauth@example.com',
               password: 'pass123',
               password_confirmation: 'pass123',
               role: 'student'
             }
           },
           headers: { 'Authorization' => "Bearer #{token}" }

      expect(response).to have_http_status(:unauthorized)
      json = response.parsed_body
      expect(json['error']).to eq('Unauthorized')
    end

    it 'returns validation errors when data is invalid' do
      post '/api/admin/users',
           params: {
             user: {
               name: '',
               email: '',
               password: '123',
               password_confirmation: '',
               role: ''
             }
           },
           headers: { 'Authorization' => "Bearer #{@admin_token}" }

      expect(response).to have_http_status(:unprocessable_entity)
      json = response.parsed_body
      expect(json['errors']).to be_present
    end
  end
end
