module Api
  class SubjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!, only: %i[create destroy]

    def index
      return render_teacher_subjects(params[:teacher_id]) if params[:teacher_id].present?

      return render_class_subjects(params[:class_id]) if params[:class_id].present?

      render_all_subjects
    end

    def create
      subject = Subject.new(subject_params)
      if subject.save
        render json: subject, status: :created
      else
        render json: { errors: subject.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      subject = Subject.find(params[:id])
      subject.destroy
      render json: { message: 'Subject deleted successfully' }
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Subject not found' }, status: :not_found
    end

    private

    def subject_params
      params.require(:subject).permit(:name)
    end

    def authorize_admin!
      return if current_user&.role == 'admin'

      render json: { error: 'Unauthorized: Admins only' }, status: :unauthorized
    end

    def render_teacher_subjects(teacher_id)
      teacher = User.find_by(id: teacher_id, role: 'teacher')
      return render json: { error: 'Teacher not found' }, status: :not_found unless teacher

      assignments = SchoolClassSubject
                    .includes(:subject, :school_class)
                    .where(teacher_id: teacher_id)

      results = assignments.map do |a|
        {
          assignment_id: a.id,
          subject_name: a.subject.name,
          class_name: a.school_class.name,
          class_id: a.school_class.id
        }
      end

      render json: results
    end

    def render_class_subjects(class_id)
      class_id = class_id.to_i
      school_class = SchoolClass.find_by(id: class_id)
      return render json: { error: 'Class not found' }, status: :not_found unless school_class

      subjects = school_class.subjects.select(:id, :name)
      render json: subjects
    end

    def render_all_subjects
      subjects = Subject.order(:name)
      render json: subjects.as_json(only: %i[id name])
    end
  end
end
