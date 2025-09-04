module Api
  class StudentArchivesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_student!

    def show
      student_id = current_user.id
      result = {}

      labels = SchoolClassArchive.distinct.pluck(:label)

      labels.each do |label|
        data = gather_student_data_for_label(label, student_id)
        result[label] = data if data
      end

      render json: result
    end

    private

    def authorize_student!
      return if current_user&.role == 'student'

      render json: { error: 'Unauthorized: Students only' }, status: :unauthorized
    end

    def subject_name_by_id(archive, subject_id)
      assignment = archive.data['assignments'].find { |a| a['subject_id'] == subject_id }
      assignment ? assignment['subject_name'] : 'Unknown'
    end

    def gather_student_data_for_label(label, student_id)
      archives = SchoolClassArchive.includes(:school_class).where(label: label)

      archives.each do |archive|
        class_students = archive.data['students'].map { |s| s['id'] }
        next unless class_students.include?(student_id)

        assignment_to_subject = archive.data['timetable_entries']
                                       .each_with_object({}) do |entry, hash|
          hash[entry['assignment_id']] = entry['subject_id']
        end

        subjects_data = subject_ids_from(archive).map do |subject_id|
          build_subject_data(archive, student_id, subject_id, assignment_to_subject)
        end

        return {
          class_name: archive.data['class_name'],
          subjects: subjects_data
        }
      end

      nil
    end

    def subject_ids_from(archive)
      archive.data['assignments'].pluck('subject_id').uniq
    end

    def build_subject_data(archive, student_id, subject_id, assignment_to_subject)
      grades = student_grades(archive, student_id, subject_id)
      attendances = student_attendances(archive, student_id, subject_id, assignment_to_subject)

      {
        subject_id: subject_id,
        subject_name: subject_name_by_id(archive, subject_id),
        grades: grades,
        present_count: attendances.count { |a| a['status'] == 'present' },
        absent_count: attendances.count { |a| a['status'] == 'absent' }
      }
    end

    def student_grades(archive, student_id, subject_id)
      archive.data['grades']
             .select { |g| g['student_id'] == student_id && g['subject_id'] == subject_id }
    end

    def student_attendances(archive, student_id, subject_id, assignment_to_subject)
      archive.data['attendances']
             .select do |a|
        a['user_id'] == student_id &&
          a['assignment_id'] &&
          assignment_to_subject[a['assignment_id'].to_i] == subject_id
      end
    end
  end
end
