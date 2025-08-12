# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers

  def current_token
    request.env['warden-jwt_auth.token']
  end

  def paginate(scope, order: nil, as_json_opts: {})
    per_page = (params[:per_page] || 5).to_i.clamp(1, 50)
    page_num = [params[:page].to_i, 1].max
    offset = (page_num - 1) * per_page

    scope = scope.order(order) if order.present?
    scope.limit(per_page).offset(offset).as_json(as_json_opts)
  end
end
