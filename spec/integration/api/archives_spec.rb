require 'swagger_helper'

RSpec.describe 'api/archives', type: :request do
  let(:admin) { create(:user, :admin) }
  let(:student) { create(:user, :student) }

  path '/api/school_class_archives/labels' do
    get 'List all archive labels (admin only)' do
      tags ['Archives']
      produces 'application/json'
      security [bearer_auth: []]

      let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

      response '200', 'Labels listed' do
        example 'application/json', :example, {
          labels: %w[2022-2023 2023-2024]
        }
        run_test!
      end

      response '401', 'Unauthorized (not admin)' do
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        example 'application/json', :example, {
          error: 'Unauthorized: Admins only'
        }

        run_test!
      end
    end
  end

  path '/api/school_class_archives/by_label/{label}' do
    get 'Get all archived classes for a specific label (admin only)' do
      tags ['Archives']
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :label, in: :path, type: :string, description: 'Archive label'

      let(:Authorization) { "Bearer #{generate_token_for(admin)}" }
      let(:label) { '2023-2024' }

      response '200', 'Archived classes returned' do
        example 'application/json', :example, [
          {
            id: 1,
            label: '2023-2024',
            archived_at: '2024-06-15T12:00:00Z',
            school_class: {
              id: 5,
              current_name: '11A',
              archived_name: '10A'
            }
          }
        ]
        run_test!
      end

      response '401', 'Unauthorized (not admin)' do
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        example 'application/json', :example, {
          error: 'Unauthorized: Admins only'
        }

        run_test!
      end
    end
  end

  path '/api/school_class_archives/{id}' do
    get 'Get full details of a specific archive (admin only)' do
      tags ['Archives']
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :integer

      let(:Authorization) { "Bearer #{generate_token_for(admin)}" }
      let(:school_class) { create(:school_class, name: '10A') }

      let(:id) do
        create(
          :school_class_archive,
          school_class: school_class,
          label: '2023-2024',
          data: {
            class_name: '10A',
            students: [{ id: 1, name: 'Prenume1 Nume1' }],
            assignments: [{ subject_id: 1, subject_name: 'Math' }]
          }
        ).id
      end

      response '200', 'Archive found' do
        example 'application/json', :example, {
          id: 1,
          label: '2023-2024',
          archived_at: '2024-06-15T12:00:00Z',
          school_class_id: 5,
          data: {
            class_name: '10A',
            students: [
              { id: 1, name: 'Prenume1 Nume1' },
              { id: 2, name: 'Prenume2 Nume2' }
            ],
            assignments: [
              { subject_id: 3, subject_name: 'Math' },
              { subject_id: 4, subject_name: 'Biology' }
            ]
          }
        }

        run_test!
      end

      response '404', 'Archive not found' do
        let(:id) { -1 }

        example 'application/json', :example, {
          error: 'Archive not found'
        }

        run_test!
      end

      response '401', 'Unauthorized (not admin)' do
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        run_test!
      end
    end
  end

  path '/api/student_archives' do
    get 'Get student\'s personal archive (student only)' do
      tags ['Archives']
      produces 'application/json'
      security [bearer_auth: []]

      let(:Authorization) { "Bearer #{generate_token_for(student)}" }

      response '200', 'Archive returned' do
        example 'application/json', :example, {
          '2022-2023': {
            class_name: '10A',
            subjects: [
              {
                subject_id: 1,
                subject_name: 'Math',
                grades: [{ id: 1, value: 8, created_at: '2024-06-10T00:00:00Z' }],
                present_count: 40,
                absent_count: 5
              }
            ]
          }
        }
        run_test!
      end

      response '401', 'Unauthorized (not student)' do
        let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

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
