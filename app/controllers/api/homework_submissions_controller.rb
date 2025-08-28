module Api
  class HomeworkSubmissionsController < ApplicationController
    before_action :authorize_student!

    def index
      submissions = filtered_submissions_for_student
      render json: format_submissions(submissions)
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

    private

    def authorize_student!
      return if current_user&.role == 'student'

      render json: { error: 'Unauthorized: Students only' }, status: :unauthorized
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
  end
end
