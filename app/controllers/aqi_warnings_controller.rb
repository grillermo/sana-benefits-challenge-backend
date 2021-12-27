class AQIWarningsController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: current_user.aqi_warning
  end

  def create
    aqi_warning = AQIWarning.create(permitted_params.merge(user: current_user))

    if aqi_warning.persisted?
      render json: aqi_warning
    else
      render json: { message: aqi_warning.errors_message }, status: 400
    end
  end

  private

  def permitted_params
    params.require(:aqi_warning).permit(
      :location,
      :latitude,
      :longitude,
      :threshold
    )
  end
end
