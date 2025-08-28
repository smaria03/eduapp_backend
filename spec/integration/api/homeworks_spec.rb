require 'swagger_helper'

RSpec.describe 'api/homeworks', type: :request do
  let(:teacher) { create(:user, :teacher) }
  let(:student) { create(:user, :student) }
  let(:subject_rec) { create(:subject) }
  let(:school_class) { create(:school_class) }
  let(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject_rec,
                                  teacher: teacher)
  end

  let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }

  before do
    assignment
    student.update!(school_class: school_class)
  end

  path '/api/homeworks' do
    get 'List teacher’s homeworks' do
      tags ['Homeworks']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :assignment_id, in: :query, type: :integer, required: false

      response '200', 'Homeworks retrieved for current teacher' do
        let!(:homework) do
          create(:homework, title: 'Tema 1', assignment: assignment, deadline: '2025-09-10')
        end

        example 'application/json', :example, [
          {
            id: 1,
            title: 'Tema 1',
            description: nil,
            deadline: '2025-09-10',
            assignment_id: 1
          }
        ]

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end

      response '200', 'Homeworks retrieved for student' do
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        let!(:homework) do
          create(:homework, title: 'Tema elev', assignment: assignment, deadline: '2025-09-15')
        end

        example 'application/json', :example, [
          {
            id: 1,
            title: 'Tema elev',
            description: nil,
            deadline: '2025-09-15',
            assignment_id: 1
          }
        ]

        run_test!
      end
    end

    post 'Create a homework (only if teacher owns assignment)' do
      tags ['Homeworks']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :homework, in: :body, schema: {
        type: :object,
        properties: {
          homework: {
            type: :object,
            properties: {
              title: { type: :string },
              description: { type: :string },
              deadline: { type: :string, format: :date },
              assignment_id: { type: :integer }
            },
            required: %w[title deadline assignment_id]
          }
        }
      }

      response '201', 'Homework created successfully' do
        let(:homework) do
          {
            homework: {
              title: 'Tema 1',
              description: 'Exerciții capitolul 2',
              deadline: '2025-09-10',
              assignment_id: assignment.id
            }
          }
        end

        example 'application/json', :example, {
          id: 1,
          title: 'Tema 1',
          description: 'Exerciții capitolul 2',
          deadline: '2025-09-10',
          assignment_id: 1
        }

        run_test!
      end

      response '401', 'Unauthorized if not teacher of assignment' do
        let(:homework) do
          {
            homework: {
              title: 'Hack',
              description: 'Wrong teacher',
              deadline: '2025-09-10',
              assignment_id: create(:school_class_subject).id
            }
          }
        end

        example 'application/json', :example, {
          error: 'Not authorized to upload homeworks for this assignment'
        }

        run_test!
      end
    end
  end

  path '/api/homeworks/{id}' do
    parameter name: :id, in: :path, type: :integer

    delete 'Delete a homework (only by owning teacher)' do
      tags ['Homeworks']
      security [bearer_auth: []]
      produces 'application/json'

      let!(:homework) { create(:homework, assignment: assignment) }
      let(:id) { homework.id }

      response '200', 'Homework deleted successfully' do
        example 'application/json', :example, {
          message: 'Homework deleted successfully'
        }

        run_test!
      end

      response '401', 'Unauthorized if not owning teacher' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :teacher))}" }

        example 'application/json', :example, {
          error: 'Not authorized to delete this homework'
        }

        run_test!
      end
    end
  end
end
