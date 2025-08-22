require 'rails_helper'

describe 'Quizzes API', type: :request do
  let!(:teacher)  { create(:user, :teacher, password: 'teacher123') }
  let!(:subject)  { create(:subject) }
  let!(:school_class) { create(:school_class) }
  let!(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject, teacher: teacher)
  end

  before do
    post '/api/login', params: { email: teacher.email, password: 'teacher123', role: 'teacher' }
    @teacher_token = response.parsed_body['user']['token']
  end

  let(:headers) { { 'Authorization' => "Bearer #{@teacher_token}" } }

  describe 'POST /api/quizzes' do
    it 'creates a quizzes with questions and options' do
      expect do
        post '/api/quizzes',
             headers: headers,
             params: {
               quiz: {
                 title: 'Test Quiz',
                 description: 'Final chapter test',
                 deadline: 1.week.from_now,
                 time_limit: 30,
                 assignment_id: assignment.id,
                 questions: [
                   {
                     question_text: '2 + 2 = ?',
                     point_value: 3,
                     options: [
                       { text: '4', is_correct: true },
                       { text: '3', is_correct: false }
                     ]
                   }
                 ]
               }
             }
      end.to change(Quiz::Quiz, :count)
        .by(1).and change(Quiz::QuizQuestion, :count)
        .by(1).and change(Quiz::QuizOption, :count).by(2)

      expect(response).to have_http_status(:created)
      expect(response.parsed_body['message']).to eq('Quiz created successfully')
    end

    it 'returns 403 if teacher does not own the assignment' do
      other_teacher = create(:user, :teacher)
      other_assignment = create(:school_class_subject, teacher: other_teacher)

      post '/api/quizzes',
           headers: headers,
           params: {
             quiz: {
               title: 'Unauthorized Quiz',
               description: 'Invalid access',
               deadline: 1.day.from_now,
               time_limit: 20,
               assignment_id: other_assignment.id,
               questions: []
             }
           }

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body['error'])
        .to eq('Not authorized to create quizzes for this assignment')
    end
  end

  describe 'DELETE /api/quizzes/:id' do
    let!(:quiz) do
      create(:quiz, assignment: assignment).tap do |q|
        question = create(:quiz_question, quiz: q)
        create_list(:quiz_option, 2, question: question)
      end
    end

    it 'deletes the quizzes if teacher owns the assignment' do
      expect do
        delete "/api/quizzes/#{quiz.id}", headers: headers
      end.to change(Quiz::Quiz, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body['message']).to eq('Quiz deleted successfully')
    end

    it 'returns 403 if teacher does not own the quizzes' do
      other_teacher = create(:user, :teacher, password: 'other123')
      other_quiz = create(:quiz, assignment: create(:school_class_subject, teacher: other_teacher))

      post '/api/login',
           params: { email: other_teacher.email, password: 'other123', role: 'teacher' }
      response.parsed_body['user']['token']

      delete "/api/quizzes/#{other_quiz.id}", headers: { 'Authorization' => "Bearer #{@teacher_token}" }

      expect(response).to have_http_status(:unauthorized)
      expect(response.parsed_body['error']).to eq('Not authorized to delete this quiz')
    end

    it 'returns 404 if quizzes does not exist' do
      delete '/api/quizzes/999999', headers: headers

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body['error']).to eq('Quiz not found')
    end
  end
end
