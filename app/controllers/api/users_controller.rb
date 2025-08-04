# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def register
      user = User.new(user_params)
      if user.save
        render json: { message: 'User registered successfully' }, status: :created
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

    def show
      user = User.find_by(id: params[:id])

      if user
        render json: { id: user.id, name: user.name, role: user.role }
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :role)
    end
  end
end
