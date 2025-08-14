require 'swagger_helper'

RSpec.describe 'api/grades', type: :request do
  let(:teacher) { create(:user, :teacher, password: 'teacher123') }
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

  path '/api/grades' do
    get 'List grades (teachers only, scoped to current teacher)' do
      tags ['Grades']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :student_id, in: :query, type: :integer, required: false
      parameter name: :subject_id, in: :query, type: :integer, required: false

      response '200', 'Grades retrieved for current teacher' do
        let!(:g1) do
          create(:grade, value: 8, student: student, subject: subject_rec, teacher: teacher)
        end

        example 'application/json', :example, [
          { id: 1, value: 8, student_id: 3, teacher_id: 2, subject_id: 5,
            created_at: '2025-08-14T13:00:00Z' }
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

      response '401', 'Unauthorized (non-teacher)' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :admin))}" }

        example 'application/json', :example, {
          error: 'Unauthorized: Teachers only'
        }

        run_test!
      end
    end

    post 'Create a grade (teachers only, must be assigned to class-subject)' do
      tags ['Grades']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          grade: {
            type: :object,
            properties: {
              value: { type: :integer, minimum: 1, maximum: 10 },
              student_id: { type: :integer },
              subject_id: { type: :integer }
            },
            required: %w[value student_id subject_id]
          }
        },
        required: ['grade']
      }

      response '201', 'Grade added successfully' do
        let(:payload) do
          { grade: { value: 9, student_id: student.id, subject_id: subject_rec.id }}
        end

        example 'application/json', :example, {
          message: 'Grade added successfully',
          grade: { id: 1, value: 9, student_id: 10, teacher_id: 5, subject_id: 3 }
        }

        run_test!
      end

      response '403', 'Teacher not assigned to this subject for the student class' do
        before { assignment.destroy }
        let(:payload) do
          { grade: { value: 7, student_id: student.id, subject_id: subject_rec.id }}
        end

        example 'application/json', :example, {
          error: 'Unauthorized: You are not assigned to this subject for this class'
        }

        run_test!
      end

      response '422', 'Invalid student or subject' do
        let(:payload) { { grade: { value: 7, student_id: 999_999, subject_id: subject_rec.id }} }

        example 'application/json', :example, {
          error: 'Invalid student or subject'
        }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:payload) do
          { grade: { value: 7, student_id: student.id, subject_id: subject_rec.id }}
        end

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end

      response '401', 'Unauthorized (non-teacher)' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :admin))}" }
        let(:payload) do
          { grade: { value: 7, student_id: student.id, subject_id: subject_rec.id }}
        end

        example 'application/json', :example, {
          error: 'Unauthorized: Teachers only'
        }

        run_test!
      end
    end
  end

  path '/api/grades/{id}' do
    parameter name: :id, in: :path, type: :integer

    patch 'Update a grade (only owner teacher)' do
      tags ['Grades']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      let(:grade) do
        create(:grade, value: 6, student: student, subject: subject_rec, teacher: teacher)
      end
      let(:id) { grade.id }

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          grade: {
            type: :object,
            properties: { value: { type: :integer, minimum: 1, maximum: 10 }},
            required: ['value']
          }
        },
        required: ['grade']
      }

      response '200', 'Grade updated' do
        let(:payload) { { grade: { value: 10 }} }

        example 'application/json', :example, {
          message: 'Grade updated',
          grade: { id: 1, value: 10, student_id: 10, teacher_id: 5, subject_id: 3 }
        }

        run_test!
      end

      response '403', 'Forbidden (not the owner teacher or not assigned anymore)' do
        let(:payload) { { grade: { value: 5 }} }
        before do
          other_teacher = create(:user, :teacher)
          grade.update!(teacher: other_teacher)
        end

        example 'application/json', :example, { error: 'Forbidden' }
        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:payload) { { grade: { value: 5 }} }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }
        run_test!
      end
    end

    delete 'Delete a grade (only owner teacher)' do
      tags ['Grades']
      produces 'application/json'
      security [bearer_auth: []]

      let(:grade) do
        create(:grade, value: 4, student: student, subject: subject_rec, teacher: teacher)
      end
      let(:id) { grade.id }

      response '204', 'Grade deleted' do
        run_test!
      end

      response '403', 'Forbidden (not the owner teacher or not assigned anymore)' do
        before do
          other_teacher = create(:user, :teacher)
          grade.update!(teacher: other_teacher)
        end

        example 'application/json', :example, { error: 'Forbidden' }
        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end
    end
  end
end

def generate_token_for(user)
  Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first
end
