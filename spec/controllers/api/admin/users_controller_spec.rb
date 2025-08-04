require 'rails_helper'

describe 'POST /api/admin/users', type: :request do
  let!(:admin) { create(:user, :admin, password: 'admin123') }
  let!(:teacher) { create(:user, :teacher, password: 'teacher123') }

  let(:admin_token) do
    post '/api/login', params: { email: admin.email, password: 'admin123', role: 'admin' }
    response.parsed_body['user']['token']
  end

  let(:teacher_token) do
    post '/api/login', params: { email: teacher.email, password: 'teacher123', role: 'teacher' }
    response.parsed_body['user']['token']
  end

  describe 'when requester is admin' do
    it 'creates a student if data is valid' do
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
             headers: { 'Authorization' => "Bearer #{admin_token}" }
      end.to change(User, :count).by(1)

      expect(response).to have_http_status(:created)
      json = response.parsed_body
      expect(json['user']['email']).to eq('studentnew@example.com')
    end

    it 'returns validation errors if data is invalid' do
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
           headers: { 'Authorization' => "Bearer #{admin_token}" }

      expect(response).to have_http_status(:unprocessable_entity)
      json = response.parsed_body
      expect(json['errors']).to be_present
    end
  end

  describe 'when requester is NOT admin' do
    it 'does not allow user creation' do
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
           headers: { 'Authorization' => "Bearer #{teacher_token}" }

      expect(response).to have_http_status(:unauthorized)
      json = response.parsed_body
      expect(json['error']).to eq('Unauthorized')
    end
  end
end
