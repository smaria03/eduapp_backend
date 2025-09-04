require 'swagger_helper'

RSpec.describe 'api/reports', type: :request do
  let(:teacher) { create(:user, :teacher) }
  let(:student) { create(:user, :student) }
  let(:subject_rec) { create(:subject) }
  let(:school_class) { create(:school_class) }
  let(:assignment) do
    create(:school_class_subject, teacher: teacher, subject: subject_rec,
                                  school_class: school_class)
  end
  let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }

  before do
    assignment
    student.update!(school_class: school_class)
  end

  path '/api/class_reports/{id}' do
    get 'Returns detailed report for a class (teacher only)' do
      tags ['Reports']
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :integer, description: 'Class ID'

      let(:id) { school_class.id }

      response '200', 'Class report retrieved' do
        example 'application/json', :example, {
          class_name: '10B',
          students_count: 20,
          subjects: [
            {
              subject: 'Math',
              grades: {
                per_student: [
                  { name: 'Prenume Nume', average: 8.25 }
                ],
                class_average: 7.6
              },
              attendance: {
                present: 45,
                absent: 5
              },
              homeworks: [
                { title: 'Tema 1', submitted: '18/20', average_grade: 7.5 }
              ],
              quizzes: [
                { title: 'Test 1', submitted: '19/20', average_score: 8.0 }
              ]
            }
          ]
        }
        run_test!
      end

      response '401', 'Unauthorized (not a teacher)' do
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        example 'application/json', :example, {
          error: 'Unauthorized: Teachers only'
        }

        run_test!
      end

      response '401', 'Teacher not assigned to class' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :teacher))}" }

        example 'application/json', :example, {
          error: 'Unauthorized: You don’t teach this class'
        }

        run_test!
      end
    end
  end

  path '/api/student_reports' do
    get 'Returns personal report for a student (student only)' do
      tags ['Reports']
      produces 'application/json'
      security [bearer_auth: []]

      let(:Authorization) { "Bearer #{generate_token_for(student)}" }

      response '200', 'Student report retrieved' do
        example 'application/json', :example, {
          student_name: 'Prenume Nume',
          class_name: '10B',
          overall_average: 8.2,
          class_position: 4,
          total_absences: 3,
          subjects: [
            {
              subject: 'Math',
              average: 8.5,
              absences: 1,
              homeworks: {
                submitted: 3,
                total: 4
              },
              quizzes: [
                {
                  quiz_title: 'Test 1',
                  score: 9.0
                }
              ]
            }
          ]
        }
        run_test!
      end

      response '401', 'Unauthorized (not a student)' do
        let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }

        example 'application/json', :example, {
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
