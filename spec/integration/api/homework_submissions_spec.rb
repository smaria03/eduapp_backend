require 'swagger_helper'

RSpec.describe 'api/homework_submissions', type: :request do
  let(:teacher) { create(:user, :teacher) }
  let(:student) { create(:user, :student) }
  let(:subject_rec) { create(:subject) }
  let(:school_class) { create(:school_class) }
  let(:assignment) do
    create(:school_class_subject, school_class: school_class, subject: subject_rec,
                                  teacher: teacher)
  end
  let(:homework) do
    create(:homework, assignment: assignment, title: 'HW 1', description: 'Do ex 1-5',
                      deadline: Time.zone.today + 2.days)
  end
  let(:Authorization) { "Bearer #{generate_token_for(student)}" }

  before do
    assignment
    homework
    student.update!(school_class: school_class)
  end

  path '/api/homework_submissions' do
    get "List student's homework submissions (optionally filter by subject_id)" do
      tags ['Homework Submissions']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :subject_id, in: :query, type: :integer, required: false

      response '200', 'Submissions retrieved for current student' do
        let!(:submission) do
          s = build(:homework_submission, homework: homework, student: student)
          s.file.attach(
            io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
            filename: 'sample.pdf',
            content_type: 'application/pdf'
          )
          s.save!
          s
        end
        let(:subject_id) { nil }

        example 'application/json', :example, [
          {
            id: 1,
            homework_id: 4,
            homework_title: 'HW 1',
            homework_description: 'Do ex 1-5',
            deadline: '2025-08-30',
            file_attached: true,
            grade: nil
          }
        ]

        run_test!
      end

      response '200', 'Filtered by subject_id' do
        let!(:submission) do
          s = build(:homework_submission, homework: homework, student: student)
          s.file.attach(
            io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
            filename: 'sample.pdf',
            content_type: 'application/pdf'
          )
          s.save!
          s
        end
        let(:subject_id) { subject_rec.id }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end

      response '401', 'Unauthorized (non-student)' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :teacher))}" }

        example 'application/json', :example, {
          error: 'Unauthorized: Students only'
        }

        run_test!
      end
    end
  end

  path '/api/homework_submissions' do
    post 'Submit homework (student uploads a file)' do
      tags ['Homework Submissions']
      consumes 'multipart/form-data'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :homework_id, in: :formData, type: :integer, required: true
      parameter name: :file,        in: :formData, type: :file,    required: true

      response '201', 'Homework submitted successfully' do
        let(:homework_id) { homework.id }
        let(:file) do
          fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf')
        end

        example 'application/json', :example, {
          message: 'Homework submitted successfully'
        }

        run_test!
      end

      response '404', 'Homework not found' do
        let(:homework_id) { 999_999 }
        let(:file) do
          fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf')
        end

        example 'application/json', :example, {
          error: 'Homework not found'
        }

        run_test!
      end

      response '403', 'Forbidden: student not in assignment class' do
        before do
          student.update!(school_class: create(:school_class))
        end

        let(:homework_id) { homework.id }
        let(:file) do
          fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf')
        end

        example 'application/json', :example, {
          error: 'You are not allowed to submit this homework for this class'
        }

        run_test!
      end

      response '422', 'Already submitted' do
        before do
          s = build(:homework_submission, homework: homework, student: student)
          s.file.attach(
            io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
            filename: 'sample.pdf',
            content_type: 'application/pdf'
          )
          s.save!
        end

        let(:homework_id) { homework.id }
        let(:file) do
          fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf')
        end

        example 'application/json', :example, {
          error: 'Homework already submitted'
        }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:homework_id) { homework.id }
        let(:file) do
          fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf')
        end

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end

      response '401', 'Unauthorized (non-student)' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :teacher))}" }
        let(:homework_id) { homework.id }
        let(:file) do
          fixture_file_upload(Rails.root.join('spec/fixtures/files/sample.pdf'), 'application/pdf')
        end

        example 'application/json', :example, {
          error: 'Unauthorized: Students only'
        }

        run_test!
      end
    end
  end

  path '/api/homework_submissions/{id}' do
    parameter name: :id, in: :path, type: :integer

    delete 'Delete own submission (student only)' do
      tags ['Homework Submissions']
      security [bearer_auth: []]
      produces 'application/json'

      let!(:submission) do
        s = build(:homework_submission, homework: homework, student: student)
        s.file.attach(
          io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
          filename: 'sample.pdf',
          content_type: 'application/pdf'
        )
        s.save!
        s
      end
      let(:id) { submission.id }

      response '200', 'Submission deleted successfully' do
        example 'application/json', :example, {
          message: 'Homework submission deleted successfully'
        }

        run_test!
      end

      response '404', 'Not found or not owned by current student' do
        let(:id) { 9_999_999 }

        example 'application/json', :example, {
          error: 'Submission not found or not yours'
        }

        run_test!
      end

      response '403', 'Cannot delete a graded submission' do
        before do
          submission.update!(grade: 10) if submission.respond_to?(:grade)
        end

        example 'application/json', :example, {
          error: 'Cannot delete a graded submission'
        }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end

      response '401', 'Unauthorized (non-student)' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :teacher))}" }

        example 'application/json', :example, {
          error: 'Unauthorized: Students only'
        }

        run_test!
      end
    end
  end

  path '/api/homework_submissions/{id}/grade' do
    parameter name: :id, in: :path, type: :integer

    patch 'Assign a grade to a submission (teacher only)' do
      tags ['Homework Submissions']
      security [bearer_auth: []]
      consumes 'application/json'
      produces 'application/json'

      parameter name: :grade, in: :body, schema: {
        type: :object,
        properties: {
          grade: { type: :integer, example: 9 }
        },
        required: ['grade']
      }

      let!(:submission) do
        s = build(:homework_submission, homework: homework, student: student)
        s.file.attach(
          io: Rails.root.join('spec/fixtures/files/sample.pdf').open,
          filename: 'sample.pdf',
          content_type: 'application/pdf'
        )
        s.save!
        s
      end

      let(:id) { submission.id }
      let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }
      let(:grade) { { grade: 9 } }

      response '200', 'Grade assigned successfully' do
        example 'application/json', :success, {
          message: 'Grade updated',
          grade: 9
        }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }

        example 'application/json', :unauthenticated, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end

      response '401', 'Unauthorized: not the owner teacher' do
        let(:Authorization) { "Bearer #{generate_token_for(create(:user, :teacher))}" }

        example 'application/json', :unauthorized, {
          error: 'Unauthorized: Not your homework'
        }

        run_test!
      end

      response '422', 'Grade out of allowed range' do
        let(:grade) { { grade: 20 } }

        example 'application/json', :invalid, {
          error: 'Grade must be greater than 0 and less than or equal to 10'
        }

        run_test!
      end
    end
  end
end
