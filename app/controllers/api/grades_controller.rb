module Api
  class GradesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_teacher!
    before_action :set_grade, only: %i[update destroy]
    before_action :check_ownership!, only: %i[update destroy]

    def index
      grades = Grade.where(teacher_id: current_user.id)
      grades = grades.where(student_id: params[:student_id]) if params[:student_id].present?
      grades = grades.where(subject_id: params[:subject_id]) if params[:subject_id].present?

      render json: grades.as_json(only: %i[id value student_id teacher_id subject_id
                                           created_at])
    end

    def create
      return unless validate_teacher_assignment?(grade_params[:student_id],
                                                 grade_params[:subject_id])

      grade = Grade.new(grade_params.merge(teacher: current_user))

      if grade.save
        render json: { message: 'Grade added successfully', grade: grade }, status: :created
      else
        render json: { errors: grade.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @grade.update(grade_params.slice(:value))
        render json: { message: 'Grade updated', grade: @grade }
      else
        render json: { errors: @grade.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @grade.destroy
      head :no_content
    end

    private

    def grade_params
      params.require(:grade).permit(:value, :student_id, :subject_id)
    end

    def set_grade
      @grade = Grade.find(params[:id])
    end

    def check_ownership!
      unless @grade.teacher_id == current_user.id
        render json: { error: 'Forbidden' }, status: :forbidden
        return
      end

      nil unless validate_teacher_assignment?(@grade.student_id, @grade.subject_id)
    end

    def authorize_teacher!
      return if current_user&.role == 'teacher'

      render json: { error: 'Unauthorized: Teachers only' }, status: :unauthorized
    end

    def validate_teacher_assignment?(student_id, subject_id)
      student = User.find_by(id: student_id, role: 'student')
      subject = Subject.find_by(id: subject_id)

      if student.nil? || subject.nil?
        render json: { error: 'Invalid student or subject' }, status: :unprocessable_entity
        return false
      end

      assignment = SchoolClassSubject.find_by(
        school_class_id: student.school_class_id,
        subject_id: subject.id,
        teacher_id: current_user.id
      )

      unless assignment
        render json: { error: 'Unauthorized: You are not assigned to this subject for this class' },
               status: :forbidden
        return false
      end

      true
    end
  end
end
