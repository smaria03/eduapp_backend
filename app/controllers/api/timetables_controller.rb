# app/controllers/api/timetables_controller.rb
module Api
  class TimetablesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!, only: %i[create update destroy]
    before_action :set_entry, only: %i[update destroy]

    def index
      scope = current_user.role == 'admin' ? admin_scope_from_params : user_scope_for_current
      scope = apply_common_filters(scope)

      entries = scope.joins(:period)
                     .includes(assignment: %i[subject teacher school_class])
                     .order(:weekday, 'periods.start_time').references(:periods)

      render json: entries.map(&:as_json)
    end

    def create
      entry = TimetableEntry.new(entry_params)
      if entry.save
        render json: entry.as_json, status: :created
      else
        render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @entry.update(entry_params)
        render json: @entry.as_json
      else
        render json: { errors: @entry.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @entry.destroy
      head :no_content
    end

    private

    def set_entry
      @entry = TimetableEntry.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Timetable entry not found' }, status: :not_found
    end

    def entry_params
      params.require(:timetable_entry).permit(:assignment_id, :weekday, :period_id)
    end

    def authorize_admin!
      return if current_user&.role == 'admin'

      render json: { error: 'Unauthorized: Admins only' }, status: :unauthorized
    end

    def user_scope_for_current
      base = TimetableEntry.joins(:assignment)
      case current_user.role
      when 'teacher'
        base.where(school_class_subjects: { teacher_id: current_user.id })
      when 'student'
        return TimetableEntry.none if current_user.school_class_id.blank?

        base.where(school_class_subjects: { school_class_id: current_user.school_class_id })
      else
        TimetableEntry.none
      end
    end

    def apply_common_filters(scope)
      scope = scope.where(weekday: params[:weekday]) if params[:weekday].present?
      scope = scope.where(period_id: params[:period_id]) if params[:period_id].present?
      if params[:assignment_id].present?
        scope = scope.where(school_class_subjects: { id: params[:assignment_id] })
      end
      scope
    end

    def admin_scope_from_params
      scope = TimetableEntry.joins(:assignment)
      if params[:class_id].present?
        scope = scope.where(school_class_subjects: { school_class_id: params[:class_id] })
      end
      if params[:teacher_id].present?
        scope = scope.where(school_class_subjects: { teacher_id: params[:teacher_id] })
      end
      scope
    end
  end
end
