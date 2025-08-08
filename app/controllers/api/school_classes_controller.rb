module Api
  class SchoolClassesController < ApplicationController
    before_action :set_school_class, only: %i[show update destroy remove_student add_student]
    before_action :authenticate_user!
    before_action :authorize_admin!, only: %i[create update destroy remove_student add_student]

    def index
      render json: SchoolClass.all
    end

    def show
      render json: @school_class, include: :students
    end

    def create
      student_ids = school_class_params[:student_ids] || []

      return unless validate_student_ids?(student_ids)

      assigned_students = User.where(id: student_ids, role: 'student')
                              .where.not(school_class_id: nil)

      if assigned_students.exists?
        return render json: {
          error: 'Some students are already assigned to other classes',
          students: assigned_students.map { |s| { id: s.id, name: s.name } }
        }, status: :unprocessable_entity
      end

      school_class = SchoolClass.new(school_class_params)
      if school_class.save
        render json: school_class, status: :created
      else
        render json: { errors: school_class.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      student_ids = school_class_params[:student_ids] || []

      return unless validate_student_ids?(student_ids)

      assigned_students = User.where(id: student_ids, role: 'student')
                              .where.not(school_class_id: [nil, @school_class.id])

      if assigned_students.exists?
        return render json: {
          error: 'Some students are already assigned to other classes',
          students: assigned_students.map { |s| { id: s.id, name: s.name } }
        }, status: :unprocessable_entity
      end

      if @school_class.update(school_class_params)
        render json: @school_class
      else
        render json: { errors: @school_class.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @school_class.destroy
      head :no_content
    end

    def remove_student
      student = User.find_by(id: params[:student_id], role: 'student')

      if student.nil?
        render json: { error: 'Student not found' }, status: :not_found
        return
      end

      if student.school_class_id == @school_class.id
        student.update(school_class_id: nil)
        render json: { message: 'Student removed from class' }, status: :ok
      else
        render json: { error: 'Student does not belong to this class' },
               status: :unprocessable_entity
      end
    end

    def add_student
      student = User.find_by(id: params[:student_id], role: 'student')

      if student.nil?
        render json: { error: 'Student not found' }, status: :not_found
        return
      end

      if student.school_class_id.present?
        render json: { error: 'Student already assigned to a class' },
               status: :unprocessable_entity
        return
      end

      student.update(school_class_id: @school_class.id)
      render json: { message: 'Student added successfully' }, status: :ok
    end

    private

    def set_school_class
      @school_class = SchoolClass.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'School class not found' }, status: :not_found
    end

    def school_class_params
      params.require(:school_class).permit(:name, student_ids: [])
    end

    def authorize_admin!
      return if current_user&.role == 'admin'

      render json: { error: 'Unauthorized: Admins only' }, status: :unauthorized
    end

    def validate_student_ids?(ids)
      return true if ids.blank?

      invalid_users = User.where(id: ids).where.not(role: 'student')
      unless invalid_users.empty?
        render json: {
          error: 'Only users with role student can be assigned to a class',
          invalid_users: invalid_users.map { |u| { id: u.id, name: u.name, role: u.role } }
        }, status: :unprocessable_entity
        return false
      end
      true
    end
  end
end
