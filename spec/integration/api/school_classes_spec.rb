require 'swagger_helper'

RSpec.describe 'api/school_classes', type: :request do
  let(:admin) { create(:user, :admin) }
  let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

  path '/api/school_classes' do
    post 'Create a new school class (admin only)' do
      tags ['SchoolClasses']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :school_class, in: :body, required: true, schema: {
        type: :object,
        required: ['school_class'],
        properties: {
          school_class: {
            type: :object,
            required: %w[name student_ids],
            properties: {
              name: { type: :string, example: '10A' },
              student_ids: {
                type: :array,
                items: { type: :integer },
                example: [1, 2, 3]
              }
            }
          }
        }
      }

      response '201', 'school class created' do
        let(:school_class) do
          {
            school_class: {
              name: '10A',
              student_ids: []
            }
          }
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              id: 1,
              name: '10A',
              students: []
            }
          }
        }

        run_test!
      end

      response '422', 'invalid request' do
        let(:school_class) do
          {
            school_class: {
              name: '',
              student_ids: []
            }
          }
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              errors: ["Name can't be blank"]
            }
          }
        }

        run_test!
      end
    end

    get 'List all school classes' do
      tags ['SchoolClasses']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'school classes listed' do
        metadata[:response][:content] = {
          'application/json' => {
            example: [
              { id: 1, name: '10A', students: [] },
              { id: 2, name: '11B', students: [] }
            ]
          }
        }

        run_test!
      end
    end
  end

  path '/api/school_classes/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Show a specific school class' do
      tags ['SchoolClasses']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'school class found' do
        let(:id) { create(:school_class).id }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              id: 1,
              name: '10A',
              students: []
            }
          }
        }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { -1 }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              error: 'School class not found'
            }
          }
        }

        run_test!
      end
    end

    patch 'Update a school class (admin only)' do
      tags ['SchoolClasses']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :school_class, in: :body, required: true, schema: {
        type: :object,
        required: ['school_class'],
        properties: {
          school_class: {
            type: :object,
            properties: {
              name: { type: :string, example: '11B' },
              student_ids: {
                type: :array,
                items: { type: :integer },
                example: [4, 5]
              }
            }
          }
        }
      }

      response '200', 'school class updated' do
        let(:id) { create(:school_class).id }
        let(:school_class) { { school_class: { name: '11B' }} }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              id: 1,
              name: '11B',
              students: []
            }
          }
        }

        run_test!
      end
    end

    delete 'Delete a school class (admin only)' do
      tags ['SchoolClasses']
      produces 'application/json'
      security [bearer_auth: []]

      response '204', 'school class deleted' do
        let(:id) { create(:school_class).id }

        metadata[:response][:content] = {
          'application/json' => {
            example: nil
          }
        }

        run_test!
      end
    end
  end

  path '/api/school_classes/{id}/add_student/{student_id}' do
    parameter name: :id, in: :path, type: :integer
    parameter name: :student_id, in: :path, type: :integer

    post 'Add a student to a class (admin only)' do
      tags ['SchoolClasses']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'student added to class' do
        let(:id) { create(:school_class).id }
        let(:student_id) { create(:user, :student).id }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              message: 'Student added successfully'
            }
          }
        }

        run_test!
      end

      response '404', 'student not found' do
        let(:id) { create(:school_class).id }
        let(:student_id) { -1 }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              error: 'Student not found'
            }
          }
        }

        run_test!
      end
    end
  end

  path '/api/school_classes/{id}/remove_student/{student_id}' do
    parameter name: :id, in: :path, type: :integer
    parameter name: :student_id, in: :path, type: :integer

    delete 'Remove a student from a class (admin only)' do
      tags ['SchoolClasses']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'student removed from class' do
        let(:school_class) { create(:school_class) }
        let(:id) { school_class.id }
        let(:student_id) do
          student = create(:user, :student, school_class: school_class)
          student.id
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              message: 'Student removed from class'
            }
          }
        }

        run_test!
      end

      response '422', 'student not in this class' do
        let(:id) { create(:school_class).id }
        let(:student) { create(:user, :student, school_class: create(:school_class)) }
        let(:student_id) { student.id }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              error: 'Student does not belong to this class'
            }
          }
        }

        run_test!
      end
    end
  end
end

def generate_token_for(user)
  Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
end
