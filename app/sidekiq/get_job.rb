# frozen_string_literal: true

# GetJob
class GetJob
  include Sidekiq::Job

  sidekiq_options queue: 'weather_request'
  sidekiq_options retry: 5
  sidekiq_options expires_in: 1.hour

  def perform(token)
    Creator.get_and_save(token)
  end
end
