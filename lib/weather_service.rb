class WeatherService
  ROOT_PATH='http://api.weatherstack.com'.freeze
  ACCESS_TOKEN='e294cc831cde0fe6c95bfbade7ac980c'.freeze
  CURRENT_PATH="#{ROOT_PATH}/current?access_key=#{ACCESS_TOKEN}".freeze

  def self.current(query=nil)
    return code(601) unless query.present?

    request = HTTParty.get("#{CURRENT_PATH}&query=#{query}").parsed_response

    raise code(request['error']['code']) if error?(request)

    request
  end

  class << self

    def error?(request)
      statuses = status_code.map { |sc| sc[:code] }
      request['success'] == false && request['error'].present? && statuses.include?(request['error']['code'])
    end

    def code(number)
      status_code.find {|status| status[:code] == number }
    end

    def status_code
      [
        { code: 404, message:	'404_not_found' },
        { code: 101, message:	'missing_access_key	' },
        { code: 101, message:	'invalid_access_key	' },
        { code: 102, message:	'inactive_user	User ' },
        { code: 103, message:	'invalid_api_function' },
        { code: 104, message:	'usage_limit_reached' },
        { code: 105, message:	'function_access_restricted' },
        { code: 105, message:	'https_access_restricted' },
        { code: 601, message:	'missing_query' },
        { code: 602, message:	'no_results' },
        { code: 603, message:	'historical_queries_not_supported_on_plan' },
        { code: 604, message:	'bulk_queries_not_supported_on_plan' },
        { code: 605, message:	'invalid_language' },
        { code: 606, message:	'invalid_unit' },
        { code: 607, message:	'invalid_interval' },
        { code: 608, message:	'invalid_forecast_days' },
        { code: 609, message:	'forecast_days_not_supported_on_plan' },
        { code: 611, message:	'invalid_historical_date' },
        { code: 612, message:	'invalid_historical_time_frame' },
        { code: 613, message:	'historical_time_frame_too_long' },
        { code: 614, message:	'missing_historical_date' },
        { code: 615, message:	'request_failed' },
      ]
    end
  end
end
