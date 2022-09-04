# frozen_string_literal: true

# WeatherService
class WeatherService
  extend StatusCode

  ROOT_PATH = ENV['WEATHER_API_URL']
  ACCESS_TOKEN = ENV['WEATHER_API_TOKEN']
  CURRENT_PATH = "#{ROOT_PATH}/current?access_key=#{ACCESS_TOKEN}".freeze

  def self.current(query = nil)
    return code(601) if query.nil? || query.blank?

    request = HTTParty.get("#{CURRENT_PATH}&query=#{query}").parsed_response

    raise code(request['error']['code']) if error?(request)

    request
  end

  class << self
    def error?(request)
      statuses = STATUS.map { |sc| sc[:code] }
      request['success'] == false && request['error'].present? && statuses.include?(request['error']['code'])
    end

    def code(number)
      STATUS.find { |status| status[:code] == number }
    end
  end
end
