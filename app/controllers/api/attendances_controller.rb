module Api
  class AttendancesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_teacher!, only: %i[create update destroy]

    def index
      if current_user.role == 'teacher'
        attendances = Attendance
                        .joins("INNER JOIN school_class_subjects ON school_class_subjects.id = attendances.assignment_id")
                        .where(school_class_subjects: { teacher_id: current_user.id })
      elsif current_user.role == 'student'
        attendances = Attendance.where(user_id: current_user.id)
      else
        return render json: { error: 'Unauthorized role' }, status: :unauthorized
      end

      attendances = filter_attendances(attendances)

      render json: attendances
    end

    def create
      attendance = Attendance.new(attendance_params)

      unless attendance.assignment.teacher_id == current_user.id
        return render json: { error: 'Not authorized to create this attendance' },
                      status: :forbidden
      end

      if attendance.save
        render json: { message: 'Attendance recorded successfully', attendance: attendance },
               status: :created
      else
        render json: { errors: attendance.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      attendance = Attendance.find_by(id: params[:id])

      return render json: { error: 'Attendance not found' }, status: :not_found unless attendance

      unless attendance.assignment.teacher_id == current_user.id
        return render json: { error: 'Not authorized to update this attendance' },
                      status: :forbidden
      end

      if attendance.update(status_only_params)
        render json: { message: 'Attendance updated successfully', attendance: attendance }
      else
        render json: { errors: attendance.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      attendance = Attendance.find_by(id: params[:id])

      return render json: { error: 'Attendance not found' }, status: :not_found unless attendance

      unless attendance.assignment.teacher_id == current_user.id
        return render json: { error: 'Not authorized to delete this attendance' },
                      status: :forbidden
      end

      attendance.destroy
      head :no_content
    end

    private

    def attendance_params
      params.require(:attendance).permit(:user_id, :assignment_id, :period_id, :date, :status)
    end

    def status_only_params
      params.require(:attendance).permit(:status)
    end

    def authorize_teacher!
      return if current_user&.role == 'teacher'

      render json: { error: 'Unauthorized: Teachers only' }, status: :unauthorized
    end

    def filter_attendances(scope)
      %i[user_id assignment_id date period_id status].each do |key|
        scope = scope.where(key => params[key]) if params[key].present?
      end
      scope
    end
  end
end
