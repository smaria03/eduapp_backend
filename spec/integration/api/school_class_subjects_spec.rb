require 'swagger_helper'

RSpec.describe 'api/school_class_subjects', type: :request do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user, :student) }
  let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

  path '/api/school_classes/{school_class_id}/subjects/{subject_id}' do
    parameter name: :school_class_id, in: :path, type: :integer
    parameter name: :subject_id, in: :path, type: :integer

    post 'Assign a subject to a school class (admin only)' do
      tags ['SchoolClassSubjects']
      produces 'application/json'
      security [bearer_auth: []]

      response '201', 'Subject added to class successfully' do
        let(:school_class_id) { create(:school_class).id }
        let(:subject_id) { create(:subject).id }

        example 'application/json', :example, {
          message: 'Subject added to class successfully'
        }

        run_test!
      end

      response '422', 'Subject already assigned to class' do
        let(:school_class) { create(:school_class) }
        let(:subject) { create(:subject) }

        before { school_class.subjects << subject }

        let(:school_class_id) { school_class.id }
        let(:subject_id) { subject.id }

        example 'application/json', :example, {
          message: 'Subject already assigned to class'
        }

        run_test!
      end

      response '401', 'Unauthorized (non-admin)' do
        let(:Authorization) { "Bearer #{generate_token_for(user)}" }
        let(:school_class_id) { create(:school_class).id }
        let(:subject_id) { create(:subject).id }

        example 'application/json', :example, {
          error: 'Unauthorized: Admins only'
        }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:school_class_id) { create(:school_class).id }
        let(:subject_id) { create(:subject).id }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end
    end

    delete 'Remove a subject from a school class (admin only)' do
      tags ['SchoolClassSubjects']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Subject removed from class successfully' do
        let(:school_class) { create(:school_class) }
        let(:subject) { create(:subject) }

        before { school_class.subjects << subject }

        let(:school_class_id) { school_class.id }
        let(:subject_id) { subject.id }

        example 'application/json', :example, {
          message: 'Subject removed from class successfully'
        }

        run_test!
      end

      response '404', 'Subject not assigned to this class' do
        let(:school_class_id) { create(:school_class).id }
        let(:subject_id) { create(:subject).id }

        example 'application/json', :example, {
          message: 'Subject not assigned to this class'
        }

        run_test!
      end

      response '401', 'Unauthorized (non-admin)' do
        let(:Authorization) { "Bearer #{generate_token_for(user)}" }
        let(:school_class_id) { create(:school_class).id }
        let(:subject_id) { create(:subject).id }

        example 'application/json', :example, {
          error: 'Unauthorized: Admins only'
        }

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:school_class_id) { create(:school_class).id }
        let(:subject_id) { create(:subject).id }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end
    end
  end

  path '/api/school_classes/{school_class_id}/subjects' do
    parameter name: :school_class_id, in: :path, type: :integer

    get 'List all subjects for a school class (authenticated users)' do
      tags ['SchoolClassSubjects']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Subjects retrieved' do
        let(:Authorization) { "Bearer #{generate_token_for(user)}" }
        let(:school_class) { create(:school_class) }

        before { school_class.subjects << create(:subject, name: 'Math') }

        let(:school_class_id) { school_class.id }

        example 'application/json', :example, [
          { id: 1, name: 'Math' }
        ]

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:school_class_id) { create(:school_class).id }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end
    end
  end

  path '/api/subjects/{subject_id}/school_classes' do
    parameter name: :subject_id, in: :path, type: :integer

    get 'List all school classes for a subject (authenticated users)' do
      tags ['SchoolClassSubjects']
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'School classes retrieved' do
        let(:Authorization) { "Bearer #{generate_token_for(user)}" }
        let(:subject) { create(:subject) }

        before { subject.school_classes << create(:school_class, name: '11B') }

        let(:subject_id) { subject.id }

        example 'application/json', :example, [
          { id: 1, name: '11B' }
        ]

        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:subject_id) { create(:subject).id }

        example 'application/json', :example, {
          error: 'You need to sign in or sign up before continuing.'
        }

        run_test!
      end
    end
  end

  path '/api/school_class_subjects/{id}' do
    parameter name: :id, in: :path, type: :integer

    patch 'Assign the teacher for a class-subject (admin only)' do
      tags ['SchoolClassSubjects']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: { teacher_id: { type: :integer }},
        required: ['teacher_id']
      }

      response '200', 'Teacher updated successfully' do
        let(:Authorization) { "Bearer #{generate_token_for(admin)}" }
        let(:school_class) { create(:school_class) }
        let(:subject) { create(:subject) }
        let(:assignment) do
          SchoolClassSubject.create!(school_class: school_class, subject: subject)
        end
        let(:id) { assignment.id }
        let(:teacher) { create(:user, :teacher) }
        let(:payload) { { teacher_id: teacher.id } }

        example 'application/json', :example, { message: 'Teacher updated successfully' }
        run_test!
      end

      response '422', 'Provided user is not a teacher' do
        let(:Authorization) { "Bearer #{generate_token_for(admin)}" }
        let(:school_class) { create(:school_class) }
        let(:subject) { create(:subject) }
        let(:assignment) do
          SchoolClassSubject.create!(school_class: school_class, subject: subject)
        end
        let(:id) { assignment.id }
        let(:not_teacher) { create(:user, :student) }
        let(:payload) { { teacher_id: not_teacher.id } }

        example 'application/json', :example, { error: 'Provided user is not a teacher' }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { "Bearer #{generate_token_for(user)}" }
        let(:school_class) { create(:school_class) }
        let(:subject) { create(:subject) }
        let(:assignment) do
          SchoolClassSubject.create!(school_class: school_class, subject: subject)
        end
        let(:id) { assignment.id }
        let(:teacher) { create(:user, :teacher) }
        let(:payload) { { teacher_id: teacher.id } }

        example 'application/json', :example, { error: 'Unauthorized: Admins only' }
        run_test!
      end

      response '401', 'Unauthenticated' do
        let(:Authorization) { nil }
        let(:id) { 1 }
        let(:payload) { { teacher_id: 1 } }

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
