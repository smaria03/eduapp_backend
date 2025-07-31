module Api
  module Admin
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_admin!

      def create
        user = User.new(user_params)

        if user.save
          render json: { message: 'User created successfully', user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :role)
      end

      def authorize_admin!
        return if current_user&.role == 'admin'

        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
