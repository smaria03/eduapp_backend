module Api
  class SubjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!, only: %i[create destroy]

    def index
      if params[:teacher_id].present?
        teacher_id = params[:teacher_id]

        teacher = User.find_by(id: teacher_id, role: 'teacher')
        return render json: { error: 'Teacher not found' }, status: :not_found unless teacher

        assignments = SchoolClassSubject
                      .includes(:subject, :school_class)
                      .where(teacher_id: teacher_id)

        results = assignments.map do |a|
          {
            assignment_id: a.id,
            subject_name: a.subject.name,
            class_name: a.school_class.name
          }
        end

        return render json: results
      end

      subjects = Subject.order(:name)
      render json: subjects.as_json(only: %i[id name])
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
  end
end
