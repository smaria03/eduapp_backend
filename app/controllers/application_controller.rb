# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
