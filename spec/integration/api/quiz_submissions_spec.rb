require 'swagger_helper'

RSpec.describe 'api/quizzes/submissions', type: :request do
  let(:student) { create(:user, :student) }
  let(:Authorization) { "Bearer #{generate_token_for(student)}" }

  let(:subject_rec) { create(:subject) }
  let(:school_class) { create(:school_class) }
  let(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject_rec)
  end

  let(:quiz) do
    create(:quiz, assignment: assignment).tap do |q|
      question = create(:quiz_question, quiz: q, point_value: 3)
      create(:quiz_option, question: question, text: 'Wrong', is_correct: false)
      create(:quiz_option, question: question, text: 'Correct', is_correct: true)
    end
  end

  before do
    student.update(school_class: school_class)
    assignment
    quiz
  end

  path '/api/quizzes/submissions' do
    get 'Get all quiz submissions for current student' do
      tags ['Quiz Submissions']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :subject_id, in: :query, type: :integer, required: false

      response '200', 'List of submissions retrieved' do
        let!(:submission) do
          create(:quiz_submission, quiz: quiz, student: student, raw_score: 5, final_score: 6)
        end

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { nil }

        example 'application/json', :unauthorized, {
          error: 'Unauthorized: Students only'
        }

        run_test!
      end
    end
  end

  path '/api/quizzes/{quiz_id}/submissions' do
    post 'Submit answers for a quiz (student only)' do
      tags ['Quiz Submissions']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :quiz_id, in: :path, type: :integer, required: true
      parameter name: :answers, in: :body, schema: {
        type: :object,
        properties: {
          answers: {
            type: :array,
            items: {
              type: :object,
              properties: {
                question_id: { type: :integer },
                selected_option_ids: {
                  type: :array,
                  items: { type: :integer }
                }
              },
              required: %w[question_id selected_option_ids]
            }
          }
        },
        required: ['answers']
      }

      response '201', 'Quiz submitted successfully' do
        let(:quiz_id) { quiz.id }
        let(:answers) do
          {
            answers: [
              {
                question_id: quiz.questions.first.id,
                selected_option_ids: [quiz.questions.first.options.find(&:is_correct).id]
              }
            ]
          }
        end

        example 'application/json', :success, {
          message: 'Quiz submitted successfully',
          raw_score: 4,
          final_score: 5
        }

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { nil }
        let(:quiz_id) { quiz.id }
        let(:answers) { { answers: [] } }

        example 'application/json', :unauthorized, {
          error: 'Unauthorized: Students only'
        }

        run_test!
      end

      response '422', 'Validation error' do
        let(:quiz_id) { quiz.id }
        let(:answers) do
          {
            answers: [
              {
                question_id: quiz.questions.first.id,
                selected_option_ids: [9999]
              }
            ]
          }
        end

        example 'application/json', :error, {
          error: 'Invalid option(s) selected for question 1'
        }

        run_test!
      end
    end
  end

  path '/api/quizzes/submissions/{id}' do
    delete 'Delete a quiz submission (student only)' do
      tags ['Quiz Submissions']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :id, in: :path, type: :integer, required: true

      let(:id) do
        create(:quiz_submission, quiz: quiz, student: student).id
      end

      response '200', 'Submission deleted' do
        example 'application/json', :deleted, {
          message: 'Submission and associated answers deleted successfully'
        }

        run_test!
      end

      response '404', 'Submission not found or not yours' do
        let(:id) { 999_999 }

        example 'application/json', :not_found, {
          error: 'Submission not found or not yours'
        }

        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { nil }
        let(:id) { 123 }

        example 'application/json', :unauth, {
          error: 'Unauthorized: Students only'
        }

        run_test!
      end
    end
  end
end

def generate_token_for(user)
  Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
end
