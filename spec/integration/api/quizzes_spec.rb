require 'swagger_helper'

RSpec.describe 'api/quizzes', type: :request do
  let(:teacher) { create(:user, :teacher, password: 'teacher123') }
  let(:student) { create(:user, :student) }
  let(:subject_rec) { create(:subject) }
  let(:school_class) { create(:school_class) }
  let(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject_rec,
                                  teacher: teacher)
  end
  let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }

  before { assignment }

  path '/api/quizzes' do
    get 'List quizzes (for teacher or student)' do
      operationId 'getQuizzes'
      tags ['Quizzes']
      description <<~DESC
        Returns quizzes based on the current user's role:
        - Teachers receive full quizzes (including correct answers)
        - Students receive quizzes **without** revealing which options are correct
      DESC
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :assignment_id, in: :query, type: :integer, required: false

      response '200', 'Quizzes retrieved for teacher or student' do
        let(:Authorization) { "Bearer #{generate_token_for(user)}" }

        let(:user) { teacher } # default, will override later

        let!(:quiz) do
          create(:quiz, assignment: assignment).tap do |q|
            question = create(:quiz_question, quiz: q)
            create(:quiz_option, question: question, text: 'Correct', is_correct: true)
            create(:quiz_option, question: question, text: 'Wrong', is_correct: false)
          end
        end

        context 'when teacher' do
          let(:user) { teacher }

          run_test! do |response|
            data = JSON.parse(response.body)
            option_keys = data.first['questions'].first['options'].first.keys
            expect(option_keys).to include('id', 'text', 'is_correct')
          end
        end

        context 'when student' do
          let(:user) { student }

          before do
            student.update!(school_class: assignment.school_class)
          end

          run_test! do |response|
            data = JSON.parse(response.body)
            option_keys = data.first['questions'].first['options'].first.keys
            expect(option_keys).to include('id', 'text')
            expect(option_keys).not_to include('is_correct')
          end
        end
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }

        example 'application/json', :unauthenticated, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end

      response '404', 'Assignment not found or unauthorized' do
        let(:assignment_id) { 99_999 }
        let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }

        run_test!
      end
    end

    post 'Create a quiz (teacher only)' do
      tags ['Quizzes']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :quiz, in: :body, schema: {
        type: :object,
        properties: {
          quiz: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              deadline: { type: :string, format: :date },
              time_limit: { type: :integer },
              assignment_id: { type: :integer },
              questions: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    question_text: { type: :string },
                    point_value: { type: :integer },
                    options: {
                      type: :array,
                      items: {
                        type: :object,
                        properties: {
                          text: { type: :string },
                          is_correct: { type: :boolean }
                        },
                        required: %w[text is_correct]
                      }
                    }
                  },
                  required: %w[question_text point_value options]
                }
              }
            },
            required: %w[title deadline time_limit assignment_id questions]
          }
        },
        required: ['quiz']
      }

      response '201', 'Quiz created successfully' do
        let(:quiz) do
          {
            quiz: {
              title: 'Sample Quiz',
              description: 'A simple quiz',
              deadline: Date.tomorrow,
              time_limit: 15,
              assignment_id: assignment.id,
              questions: [
                {
                  question_text: 'What is 2 + 2?',
                  point_value: 5,
                  options: [
                    { text: '3', is_correct: false },
                    { text: '4', is_correct: true }
                  ]
                }
              ]
            }
          }
        end

        example 'application/json', :success, { message: 'Quiz created successfully' }

        run_test!
      end

      response '422', 'Validation error' do
        let(:quiz) do
          {
            quiz: {
              title: '',
              deadline: nil,
              time_limit: 0,
              assignment_id: assignment.id,
              questions: []
            }
          }
        end

        example 'application/json', :error, {
          errors: ['Title can\'t be blank', 'Deadline can\'t be blank']
        }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }

        let(:quiz) do
          {
            quiz: {
              title: 'Test Quiz',
              description: 'desc',
              deadline: Time.zone.today,
              time_limit: 10,
              assignment_id: assignment.id,
              questions: []
            }
          }
        end

        example 'application/json', :unauth, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end
    end
  end

  path '/api/quizzes/{id}' do
    parameter name: :id, in: :path, type: :integer

    delete 'Delete a quiz (teacher only)' do
      tags ['Quizzes']
      produces 'application/json'
      security [bearer_auth: []]

      let(:quiz_record) { create(:quiz, assignment: assignment) }
      let(:id) { quiz_record.id }

      response '200', 'Quiz deleted' do
        run_test!
      end

      response '401', 'Not authorized' do
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        example 'application/json', :unauthorized, {
          error: 'Not authorized to delete this quiz'
        }

        run_test!
      end

      response '404', 'Quiz not found' do
        let(:id) { 99_999 }

        example 'application/json', :not_found, {
          error: 'Quiz not found'
        }

        run_test!
      end
    end
  end
end

def generate_token_for(user)
  Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
end
