class AQIWarningsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user.aqi_warning
  end
end
