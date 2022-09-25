# frozen_string_literal: true

# Creator
class Creator
  def self.call(params)
    return { error: 'error', message: 'missing_params: [:token, :location]' } unless validate_params(params)

    model = find_or_create_model(params)

    GetJob.perform_async(model.token)

    model.token
  end

  def self.get_and_save(token)
    model = get_model(token)

    weather = WeatherService.current(model.location)

    model.update(data: weather)
  end

  def self.show(token)
    return { error: 'error', message: 'missing_params: [:token]' } if token.nil? || token.blank?

    model = get_model(token)
    return model.attributes if model.present?

    nil
  end

  class << self
    def find_or_create_model(params)
      model = Weather.find_by(location: params[:location])

      if model.present? && (Time.zone.today.mjd - model.created_at.to_date.mjd) <= 1
        model
      else
        Weather.create!(params)
      end
    end

    def get_model(token)
      Weather.find_by(token: token)
    end

    def validate_params(params)
      params[:token] && params[:location].present?
    end
  end
end
