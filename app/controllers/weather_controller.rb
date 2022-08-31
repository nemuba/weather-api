class WeatherController < ApplicationController
  def create
    weather = WeatherApi.current(params[:location])

    if weather.has_key?(:code)
      render json: weather, status: 422
    else
      render json: weather, status: :ok
    end
  end
end
