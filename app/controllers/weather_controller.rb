# frozen_string_literal: true

# WeatherController
class WeatherController < ApplicationController
  before_action :set_weather, only: [:destroy]

  def index
    weathers = Weather.all

    render_json(weathers)
  end

  def create
    data = Creator.call(weather_params.to_unsafe_h)

    if data.present? && data.is_a?(Hash) && data.key?(:error)
      render_json(data, status: :accepted)
    else
      render_json({ token: data }, status: :created)
    end
  end

  def show
    data = Creator.show(params[:token])

    if data.is_a?(Hash) && data.key?(:error)
      render_json(data, status: :accepted)
    else
      render_json(data, status: :ok)
    end
  end

  def destroy
    @weather.destroy

    render_json({ message: 'Weather remove with successfully!' })
  end

  private

  def weather_params
    params.require(:weather).permit(:token, :location)
  end

  def set_weather
    @weather = Weather.find(params[:id])
  end
end
