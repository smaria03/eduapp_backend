module Api
  class HomeworksController < ApplicationController
    before_action :authorize_teacher!, except: [:index]
    before_action :authorize_user!, only: [:index]

    def index
      if current_user.teacher?
        homeworks = Homework
                      .joins(:assignment)
                      .where(school_class_subjects: { teacher_id: current_user.id })

        homeworks = homeworks.where(assignment_id: params[:assignment_id]) if params[:assignment_id].present?

      elsif current_user.student?
        homeworks = Homework
                      .joins(:assignment)
                      .where(school_class_subjects: { school_class_id: current_user.school_class_id })

        if params[:subject_id].present?
          homeworks = homeworks.where(school_class_subjects: { subject_id: params[:subject_id] })
        end

      else
        return render json: { error: 'Unauthorized' }, status: :unauthorized
      end

      results = homeworks.map do |homework|
        {
          id: homework.id,
          title: homework.title,
          description: homework.description,
          deadline: homework.deadline,
          assignment_id: homework.assignment_id
        }
      end

      render json: results
    end

    def create
      assignment = SchoolClassSubject.find_by(id: homework_params[:assignment_id])
      return render json: { error: 'Assignment not found' }, status: :not_found unless assignment

      unless assignment.teacher_id == current_user.id
        return render json: { error: 'Not authorized to upload homeworks for this assignment' },
                      status: :unauthorized
      end

      homework = Homework.new(homework_params)

      if homework.save
        render json: homework, status: :created
      else
        render json: { errors: homework.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      homework = Homework.find_by(id: params[:id])

      return render json: { error: 'Homework not found' }, status: :not_found if homework.nil?

      unless homework.assignment.teacher_id == current_user.id
        return render json: { error: 'Not authorized to delete this homework' },
                      status: :unauthorized
      end

      homework.destroy
      render json: { message: 'Homework deleted successfully' }, status: :ok
    end

    private

    def homework_params
      params.require(:homework).permit(:title, :description, :deadline, :assignment_id)
    end

    def authorize_teacher!
      return if current_user&.role == 'teacher'

      render json: { error: 'Unauthorized: Teachers only' }, status: :unauthorized
    end

    def authorize_user!
      unless current_user&.teacher? || current_user&.student?
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
