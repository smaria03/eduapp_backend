module Api
  class LearningMaterialsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_teacher!, except: [:index]
    before_action :authorize_user!, only: [:index]

    def index
      materials = fetch_materials

      results = materials.map do |material|
        {
          id: material.id,
          title: material.title,
          description: material.description,
          uploaded_at: material.created_at,
          assignment_id: material.assignment_id,
          file_url: material.file.attached? ? url_for(material.file) : nil
        }
      end

      render json: results
    end

    def create
      assignment = SchoolClassSubject.find_by(id: params[:assignment_id])

      unless assignment && assignment.teacher_id == current_user.id
        return render json: { error: 'Not authorized to upload materials for this assignment' },
                      status: :unauthorized
      end

      material = LearningMaterial.new(material_params)
      material.file.attach(params[:file]) if params[:file].present?

      if material.save
        render json: { message: 'Material uploaded successfully', material: material },
               status: :created
      else
        render json: { errors: material.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      material = LearningMaterial.find_by(id: params[:id])

      return render json: { error: 'Material not found' }, status: :not_found if material.nil?

      unless material.assignment.teacher_id == current_user.id
        return render json: { error: 'Not authorized to delete this material' },
                      status: :unauthorized
      end

      material.destroy
      render json: { message: 'Material deleted successfully' }, status: :ok
    end

    private

    def material_params
      params.permit(:title, :description, :assignment_id)
    end

    def authorize_teacher!
      return if current_user&.role == 'teacher'

      render json: { error: 'Unauthorized: Teachers only' }, status: :unauthorized
    end

    def authorize_user!
      return if current_user&.teacher? || current_user&.student?

      render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    def fetch_materials
      return materials_for_teacher if current_user.teacher?
      return materials_for_student if current_user.student?

      render json: { error: 'Unauthorized' }, status: :unauthorized and return
    end

    def materials_for_teacher
      materials = LearningMaterial
                  .joins(:assignment)
                  .where(school_class_subjects: { teacher_id: current_user.id })

      if params[:assignment_id].present?
        materials = materials.where(assignment_id: params[:assignment_id])
      end

      materials
    end

    def materials_for_student
      materials = LearningMaterial
                  .joins(assignment: :subject)
                  .where(school_class_subjects: { school_class_id: current_user.school_class_id })

      if params[:subject_id].present?
        materials = materials.where(school_class_subjects: { subject_id: params[:subject_id] })
      end

      materials
    end
  end
end
