# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!, only: %i[students show create]
    before_action :authorize_admin!, only: [:create]
    def show
      user = User.find_by(id: params[:id])

      if user
        render json: { id: user.id, name: user.name, role: user.role }
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end

    def create
      user = User.new(user_params)

      if user.save
        render json: { message: 'User created successfully', user: user }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def login
      user = User.find_by('lower(email) = ?', params[:email].downcase)

      if user.blank? || !user.valid_password?(params[:password])
        render json: { errors: ['Invalid email/password combination'] }, status: :unauthorized
        return
      end

      sign_in(:user, user)
      render json: {
        user: {
          id: user.id,
          name: user.name,
          role: user.role,
          email: user.email,
          token: current_token
        }
      }
    end

    def students
      render json: User.where(role: 'student')
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :role)
    end

    def authorize_admin!
      return if current_user&.role == 'admin'

      render json: { error: 'Unauthorized: Admins only' }, status: :unauthorized
    end
  end
end
