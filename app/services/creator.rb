# frozen_string_literal: true

# Creator
class Creator
  def self.call(params)
    return { error: 'error', message: 'missing_params: [:token, :location]' } unless validate_params(params)
    return { error: 'error', message: 'token must be unique' } unless token_unique?(params[:token])

    model = create_model(params)

    GetJob.perform_async(model.token)
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
    def create_model(params)
      Weather.create!(params)
    end

    def get_model(token)
      Weather.find_by(token: token)
    end

    def validate_params(params)
      params[:token] && params[:location].present?
    end

    def token_unique?(token)
      unique = Weather.where(token: token).exists?

      unique == false
    end
  end
end
