# frozen_string_literal: true

# WeatherController
class WeatherController < ApplicationController
  def create
    weather = WeatherService.current(params[:location])

    if weather.key?(:code)
      render json: weather, status: :unprocessable_entity
    else
      render json: weather, status: :ok
    end
  end
end
