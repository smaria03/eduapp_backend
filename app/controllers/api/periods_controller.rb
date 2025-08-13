module Api
  class PeriodsController < ApplicationController
    before_action :authenticate_user!

    def index
      periods = Period.order(:start_time)
      render json: periods.as_json(only: %i[id start_time end_time label])
    end
  end
end
