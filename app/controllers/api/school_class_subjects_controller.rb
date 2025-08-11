module Api
  class SchoolClassSubjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!, only: %i[add remove update]
    before_action :set_school_class, only: %i[index_for_class add remove]
    before_action :set_subject, only: %i[index_for_subject add remove]
    before_action :set_assignment, only: %i[update]

    def index_for_class
      scs = @school_class.school_class_subjects.includes(:subject, :teacher)
      render json: scs.map { |row|
        {
          id: row.subject.id,
          name: row.subject.name,
          teacher: row.teacher ? { id: row.teacher.id, name: row.teacher.name } : nil
        }
      }
    end

    def index_for_subject
      render json: @subject.school_classes.select(:id, :name)
    end

    def add
      if @school_class.subjects.include?(@subject)
        render json: { message: 'Subject already assigned to class' },
               status: :unprocessable_entity
      else
        SchoolClassSubject.create!(school_class: @school_class, subject: @subject)
        render json: { message: 'Subject added to class successfully' }, status: :created
      end
    end

    def remove
      if @school_class.subjects.include?(@subject)
        @school_class.subjects.delete(@subject)
        render json: { message: 'Subject removed from class successfully' }, status: :ok
      else
        render json: { message: 'Subject not assigned to this class' }, status: :not_found
      end
    end

    def update
      teacher_id = params.require(:teacher_id)

      user = User.find_by(id: teacher_id)
      unless user&.role == 'teacher'
        render json: { error: 'Provided user is not a teacher' },
               status: :unprocessable_entity and return
      end

      @assignment.update!(teacher: user)
      render json: { message: 'Teacher updated successfully' }, status: :ok
    end

    private

    def set_school_class
      @school_class = SchoolClass.find(params[:school_class_id])
    end

    def set_subject
      @subject = Subject.find(params[:subject_id])
    end

    def set_assignment
      @assignment = SchoolClassSubject.find(params[:id])
    end

    def authorize_admin!
      return if current_user&.role == 'admin'

      render json: { error: 'Unauthorized: Admins only' }, status: :unauthorized
    end
  end
end
