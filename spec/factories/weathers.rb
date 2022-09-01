# frozen_string_literal: true

# Factory Weather
FactoryBot.define do
  factory :weather do
    token { SecureRandom.hex }
    location { Faker::Address.state }
    data { '{}' }
  end
end
