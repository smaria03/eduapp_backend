require 'swagger_helper'

RSpec.describe 'api/timetable', type: :request do
  let!(:admin)   { create(:user, :admin) }
  let!(:teacher) { create(:user, :teacher, name: 'Prof X') }
  let!(:teacher2) { create(:user, :teacher, name: 'Prof Y') }
  let!(:student) { create(:user, :student) }

  let!(:class_a) { create(:school_class, name: '9A') }
  let!(:class_b) { create(:school_class, name: '9B') }

  let!(:subject_math) { create(:subject, name: 'Math') }
  let!(:subject_rom)  { create(:subject, name: 'Romanian') }

  let!(:assignment_a_math) do
    SchoolClassSubject.create!(school_class: class_a, subject: subject_math, teacher: teacher)
  end
  let!(:assignment_a_rom) do
    SchoolClassSubject.create!(school_class: class_a, subject: subject_rom, teacher: teacher2)
  end
  let!(:assignment_b_math) do
    SchoolClassSubject.create!(school_class: class_b, subject: subject_math, teacher: teacher)
  end

  let!(:period1) { Period.create!(start_time: '08:00', end_time: '08:50') }
  let!(:period2) { Period.create!(start_time: '09:00', end_time: '09:50') }

  let(:Authorization) { "Bearer #{generate_token_for(admin)}" }

  path '/api/timetable' do
    get 'List timetable entries' do
      tags ['Timetable']
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :class_id,   in: :query, type: :integer, required: false,
                description: 'Filter by class id (admin only)'
      parameter name: :teacher_id, in: :query, type: :integer, required: false,
                description: 'Filter by teacher id (admin only)'
      parameter name: :weekday,    in: :query, type: :integer, required: false,
                description: 'Filter by weekday (1=Mon..5=Fri) — available to all roles'
      parameter name: :period_id,  in: :query, type: :integer, required: false,
                description: 'Filter by period id — available to all roles'

      response '200', 'timetable listed (admin, optional filters)' do
        before do
          TimetableEntry.create!(assignment: assignment_a_math, weekday: 1, period: period1)
          TimetableEntry.create!(assignment: assignment_b_math, weekday: 1, period: period2)
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: [
              {
                id: 123,
                weekday: 'monday',
                period_id: 3,
                period_label: '08:00–08:50',
                start_time: '08:00',
                end_time: '08:50',
                class_id: 10,
                class_name: '9A',
                subject_id: 55,
                subject_name: 'Math',
                teacher_id: 77,
                teacher_name: 'Prof X',
                assignment_id: 999
              }
            ]
          }
        }

        run_test!
      end

      response '200', 'timetable listed (teacher sees only own timetable)' do
        let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }

        before do
          TimetableEntry.create!(assignment: assignment_a_math, weekday: 2, period: period1)
          TimetableEntry.create!(assignment: assignment_a_rom,  weekday: 2, period: period2)
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: [
              {
                id: 124,
                weekday: 'tuesday',
                period_id: 3,
                period_label: '08:00–08:50',
                start_time: '08:00',
                end_time: '08:50',
                class_id: 10,
                class_name: '9A',
                subject_id: 55,
                subject_name: 'Math',
                teacher_id: 77,
                teacher_name: 'Prof X',
                assignment_id: 1000
              }
            ]
          }
        }

        run_test!
      end

      response '200', 'timetable listed (student sees own class timetable)' do
        let(:Authorization) { "Bearer #{generate_token_for(student)}" }

        before do
          student.update!(school_class: class_a)
          TimetableEntry.create!(assignment: assignment_a_math, weekday: 3, period: period1)
          TimetableEntry.create!(assignment: assignment_b_math, weekday: 3, period: period2)
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: [
              {
                id: 125,
                weekday: 'wednesday',
                period_id: 3,
                period_label: '08:00–08:50',
                start_time: '08:00',
                end_time: '08:50',
                class_id: 10,
                class_name: '9A',
                subject_id: 55,
                subject_name: 'Math',
                teacher_id: 77,
                teacher_name: 'Prof X',
                assignment_id: 1001
              }
            ]
          }
        }

        run_test!
      end
    end

    post 'Create a timetable entry (admin only)' do
      tags ['Timetable']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :timetable_entry, in: :body, required: true, schema: {
        type: :object,
        required: ['timetable_entry'],
        properties: {
          timetable_entry: {
            type: :object,
            required: %w[assignment_id weekday period_id],
            properties: {
              assignment_id: { type: :integer, example: 999 },
              weekday: { type: :integer, example: 1, description: '1=Mon..5=Fri' },
              period_id: { type: :integer, example: 3 }
            }
          }
        }
      }

      response '201', 'timetable entry created' do
        let(:timetable_entry) do
          {
            timetable_entry: {
              assignment_id: assignment_a_math.id,
              weekday: 1,
              period_id: period1.id
            }
          }
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              id: 201,
              weekday: 'monday',
              period_id: 3,
              period_label: '08:00–08:50',
              start_time: '08:00',
              end_time: '08:50',
              class_id: 10,
              class_name: '9A',
              subject_id: 55,
              subject_name: 'Math',
              teacher_id: 77,
              teacher_name: 'Prof X',
              assignment_id: 999
            }
          }
        }

        run_test!
      end

      response '401', 'unauthorized (non-admin)' do
        let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }
        let(:timetable_entry) do
          { timetable_entry: { assignment_id: assignment_a_math.id, weekday: 1,
                               period_id: period1.id }}
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: { error: 'Unauthorized: Admins only' }
          }
        }

        run_test!
      end

      response '422', 'validation error (class/teacher overlap)' do
        before do
          TimetableEntry.create!(assignment: assignment_a_math, weekday: 1, period: period1) # occupies slot
        end

        let(:timetable_entry) do
          { timetable_entry: { assignment_id: assignment_a_rom.id, weekday: 1,
                               period_id: period1.id }}
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: { errors: ['This class already has a lesson in this slot'] }
          }
        }

        run_test!
      end
    end
  end

  path '/api/timetable/{id}' do
    parameter name: :id, in: :path, type: :integer, required: true

    patch 'Update a timetable entry (admin only)' do
      tags ['Timetable']
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]

      parameter name: :timetable_entry, in: :body, required: true, schema: {
        type: :object,
        required: ['timetable_entry'],
        properties: {
          timetable_entry: {
            type: :object,
            properties: {
              weekday: { type: :integer, example: 2 },
              period_id: { type: :integer, example: 4 }
            }
          }
        }
      }

      response '200', 'timetable entry updated' do
        let(:id) do
          TimetableEntry.create!(assignment: assignment_a_math, weekday: 4, period: period1).id
        end
        let(:timetable_entry) { { timetable_entry: { weekday: 5, period_id: period2.id }} }

        metadata[:response][:content] = {
          'application/json' => {
            example: {
              id: 202,
              weekday: 'friday',
              period_id: 4,
              period_label: '09:00–09:50',
              start_time: '09:00',
              end_time: '09:50',
              class_id: 10,
              class_name: '9A',
              subject_id: 55,
              subject_name: 'Math',
              teacher_id: 77,
              teacher_name: 'Prof X',
              assignment_id: 999
            }
          }
        }

        run_test!
      end

      response '401', 'unauthorized (non-admin)' do
        let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }
        let(:id) do
          TimetableEntry.create!(assignment: assignment_a_math, weekday: 3, period: period1).id
        end
        let(:timetable_entry) { { timetable_entry: { weekday: 2 }} }

        metadata[:response][:content] = {
          'application/json' => {
            example: { error: 'Unauthorized: Admins only' }
          }
        }

        run_test!
      end
    end

    delete 'Delete a timetable entry (admin only)' do
      tags ['Timetable']
      produces 'application/json'
      security [bearer_auth: []]

      response '204', 'timetable entry deleted' do
        let(:id) do
          TimetableEntry.create!(assignment: assignment_a_math, weekday: 1, period: period2).id
        end

        metadata[:response][:content] = { 'application/json' => { example: nil }}

        run_test!
      end

      response '401', 'unauthorized (non-admin)' do
        let(:Authorization) { "Bearer #{generate_token_for(teacher)}" }
        let(:id) do
          TimetableEntry.create!(assignment: assignment_a_math, weekday: 2, period: period2).id
        end

        metadata[:response][:content] = {
          'application/json' => {
            example: { error: 'Unauthorized: Admins only' }
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
