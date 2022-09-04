# frozen_string_literal: true

# WeatherController
class WeatherController < ApplicationController
  def create
    data = Creator.call(weather_params.to_unsafe_h)

    if data.present? && data.is_a?(Hash) && data.key?(:error)
      render_json(data, status: :accepted)
    else
      render_json({}, status: :created)
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

  private

  def weather_params
    params.require(:weather).permit(:token, :location)
  end
end
