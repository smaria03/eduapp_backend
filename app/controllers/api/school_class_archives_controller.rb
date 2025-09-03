module Api
  class SchoolClassArchivesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    def show
      archive = SchoolClassArchive.find_by(id: params[:id])
      if archive
        render json: archive
      else
        render json: { error: 'Archive not found' }, status: :not_found
      end
    end

    def labels
      labels = SchoolClassArchive.distinct.pluck(:label)
      render json: { labels: labels }
    end

    def by_label
      archives = SchoolClassArchive.where(label: params[:label])

      render json: archives.map { |archive|
        school_class = SchoolClass.unscoped.find_by(id: archive.school_class_id)
        archive.as_json(only: %i[id label archived_at]).merge(
          school_class: {
            id: school_class&.id,
            current_name: school_class&.name,
            archived_name: archive.data['class_name']
          }
        )
      }
    end

    private

    def authorize_admin!
      return if current_user&.role == 'admin'

      render json: { error: 'Unauthorized: Admins only' }, status: :unauthorized
    end
  end
end
