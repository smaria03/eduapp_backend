require 'swagger_helper'

RSpec.describe 'api/attendances', type: :request do
  let(:teacher) { create(:user, :teacher, password: 'teacher123') }
  let(:student) { create(:user, :student) }
  let(:subject_rec) { create(:subject) }
  let(:school_class) { create(:school_class) }
  let(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject_rec,
                                  teacher: teacher)
  end
  let(:period) { create(:period) }
  let(:date) { Date.new(2025, 8, 21) }

  let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }

  before do
    assignment
    student.update!(school_class: school_class)
    create(:timetable_entry, assignment: assignment, period: period, weekday: :thursday)
  end

  path '/api/attendances' do
    get 'List all attendances (teacher/student)' do
      tags ['Attendances']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :assignment_id, in: :query, type: :integer, required: false
      parameter name: :date, in: :query, type: :string, format: :date, required: false
      parameter name: :user_id, in: :query, type: :integer, required: false
      parameter name: :status, in: :query, type: :string, enum: %w[present absent],
                required: false

      response '200', 'Attendances retrieved' do
        before do
          create(:attendance, user: student, assignment: assignment, period: period, date: date,
                              status: :present)
        end

        example 'application/json', :example, [
          {
            id: 1,
            user_id: 3,
            assignment_id: 7,
            period_id: 1,
            date: '2025-08-21',
            status: 'present'
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
    end

    post 'Create an attendance (teacher only)' do
      tags ['Attendances']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          attendance: {
            type: :object,
            properties: {
              user_id: { type: :integer },
              assignment_id: { type: :integer },
              period_id: { type: :integer },
              date: { type: :string, format: :date },
              status: { type: :string, enum: %w[present absent] }
            },
            required: %w[user_id assignment_id period_id date status]
          }
        },
        required: ['attendance']
      }

      response '201', 'Attendance created successfully' do
        let(:payload) do
          {
            attendance: {
              user_id: student.id,
              assignment_id: assignment.id,
              period_id: period.id,
              date: date,
              status: 'present'
            }
          }
        end

        example 'application/json', :example, {
          message: 'Attendance recorded',
          attendance: {
            id: 1,
            user_id: 3,
            assignment_id: 7,
            period_id: 1,
            date: '2025-08-21',
            status: 'present'
          }
        }

        run_test!
      end

      response '422', 'Invalid data or no class scheduled at that time' do
        let(:payload) do
          {
            attendance: {
              user_id: student.id,
              assignment_id: assignment.id,
              period_id: period.id,
              date: Date.new(2025, 8, 22),
              status: 'absent'
            }
          }
        end

        example 'application/json', :example, {
          errors: ['No scheduled class for this assignment and period on the given date']
        }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:payload) do
          {
            attendance: {
              user_id: student.id,
              assignment_id: assignment.id,
              period_id: period.id,
              date: date,
              status: 'present'
            }
          }
        end

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end
    end
  end

  path '/api/attendances/{id}' do
    parameter name: :id, in: :path, type: :integer

    delete 'Delete an attendance (teacher only)' do
      tags ['Attendances']
      produces 'application/json'
      security [bearer_auth: []]

      let(:attendance) do
        create(:attendance, user: student, assignment: assignment, period: period, date: date,
                            status: :absent)
      end
      let(:id) { attendance.id }

      response '204', 'Attendance deleted' do
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
