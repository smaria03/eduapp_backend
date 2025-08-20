module Api
  class AttendancesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_teacher!

    def index
      attendances = filter_attendances(Attendance.all)
      render json: attendances
    end

    def create
      attendance = Attendance.new(attendance_params)

      if attendance.save
        render json: { message: 'Attendance recorded successfully', attendance: attendance },
               status: :created
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

    def authorize_teacher!
      return if current_user&.role == 'teacher'

      render json: { error: 'Unauthorized: Teachers only' }, status: :unauthorized
    end

    def filter_attendances(scope)
      scope = scope.where(user_id: params[:user_id]) if params[:user_id].present?
      scope = scope.where(assignment_id: params[:assignment_id]) if params[:assignment_id].present?
      scope = scope.where(date: params[:date]) if params[:date].present?
      scope = scope.where(status: params[:status]) if params[:status].present?
      scope
    end
  end
end
