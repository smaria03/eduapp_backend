module Api
  class HomeworkSubmissionsController < ApplicationController
    before_action :authorize_student!, only: %i[create destroy]
    before_action :authorize_teacher!, only: %i[grade delete_grade]
    before_action :authorize_student_or_teacher!, only: %i[index]

    def index
      if current_user.teacher? && params[:homework_id].present?
        submissions = HomeworkSubmission
                      .includes(:student)
                      .where(homework_id: params[:homework_id])

        render json: submissions.map { |s| format_teacher_submission(s) }
      else
        submissions = filtered_submissions_for_student
        render json: format_submissions(submissions)
      end
    end

    def create
      homework = Homework.includes(:assignment).find_by(id: params[:homework_id])
      return render_not_found unless homework
      return render_forbidden unless student_can_submit?(homework)
      return render_already_submitted if already_submitted?(homework)

      submission = build_submission(homework)

      if submission.save
        render json: { message: 'Homework submitted successfully' }, status: :created
      else
        render json: { error: submission.errors.full_messages.to_sentence },
               status: :unprocessable_entity
      end
    end

    def destroy
      submission = HomeworkSubmission.find_by(id: params[:id], student_id: current_user.id)

      unless submission
        return render json: { error: 'Submission not found or not yours' },
                      status: :not_found
      end

      if submission.respond_to?(:grade) && submission.grade.present?
        return render json: { error: 'Cannot delete a graded submission' }, status: :forbidden
      end

      submission.destroy

      render json: { message: 'Homework submission deleted successfully' }, status: :ok
    end

    def grade
      submission = HomeworkSubmission.find_by(id: params[:id])
      return render json: { error: 'Submission not found' }, status: :not_found unless submission

      assignment = submission.homework.assignment
      unless assignment.teacher_id == current_user.id
        return render json: { error: 'Unauthorized: Not your homework' }, status: :unauthorized
      end

      if submission.update(grade: params[:grade])
        create_grade_for_submission(submission, assignment)
        render json: { message: 'Grade updated', grade: submission.grade }, status: :ok
      else
        render json: { error: submission.errors.full_messages.to_sentence },
               status: :unprocessable_entity
      end
    end

    def delete_grade
      submission = HomeworkSubmission.find_by(id: params[:id])
      return render json: { error: 'Submission not found' }, status: :not_found unless submission

      assignment = submission.homework.assignment
      unless assignment.teacher_id == current_user.id
        return render json: { error: 'Unauthorized: Not your homework' },
                      status: :unauthorized
      end

      if submission.update(grade: nil)
        render json: { message: 'Grade removed' }, status: :ok
      else
        render json: { error: submission.errors.full_messages.to_sentence },
               status: :unprocessable_entity
      end
    end

    private

    def authorize_student!
      return if current_user&.role == 'student'

      render json: { error: 'Unauthorized: Students only' }, status: :unauthorized
    end

    def authorize_teacher!
      return if current_user&.role == 'teacher'

      render json: { error: 'Unauthorized: Teachers only' }, status: :unauthorized
    end

    def filtered_submissions_for_student
      submissions = HomeworkSubmission
                    .includes(:homework, homework: :assignment)
                    .where(student_id: current_user.id)

      if params[:subject_id].present?
        submissions = submissions.select do |s|
          s.homework.assignment&.subject_id.to_s == params[:subject_id].to_s
        end
      end

      submissions
    end

    def format_submissions(submissions)
      submissions.map do |submission|
        {
          id: submission.id,
          homework_id: submission.homework.id,
          homework_title: submission.homework.title,
          homework_description: submission.homework.description,
          deadline: submission.homework.deadline,
          file_attached: submission.file.attached?,
          grade: submission.grade
        }
      end
    end

    def render_not_found
      render json: { error: 'Homework not found' }, status: :not_found
    end

    def render_forbidden
      render json: { error: 'You are not allowed to submit homework for this class' },
             status: :forbidden
    end

    def render_already_submitted
      render json: { error: 'Homework already submitted' }, status: :unprocessable_entity
    end

    def student_can_submit?(homework)
      homework.assignment&.school_class_id == current_user.school_class_id
    end

    def already_submitted?(homework)
      homework.submissions.exists?(student_id: current_user.id)
    end

    def build_submission(homework)
      submission = HomeworkSubmission.new(homework: homework, student: current_user)
      submission.file.attach(params[:file])
      submission
    end

    def create_grade_for_submission(submission, assignment)
      Grade.create!(
        value: params[:grade],
        student_id: submission.student_id,
        teacher_id: assignment.teacher_id,
        subject_id: assignment.subject_id
      )
    end

    def format_teacher_submission(submission)
      {
        id: submission.id,
        student_id: submission.student_id,
        student_name: submission.student.name,
        uploaded_file_url: submission.file.attached? ? url_for(submission.file) : nil,
        grade: submission.grade
      }
    end

    def authorize_student_or_teacher!
      return if %w[student teacher].include?(current_user&.role)

      render json: { error: 'Unauthorized: Students or teachers only' }, status: :unauthorized
    end
  end
end
