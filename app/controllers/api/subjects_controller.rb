module Api
  class SubjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!, only: %i[create destroy]

    def index
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
