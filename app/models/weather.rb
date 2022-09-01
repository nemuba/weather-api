# frozen_string_literal: true

# Weather
class Weather < ApplicationRecord
  validates :token, presence: true
  validates :location, presence: true
  validates :data, presence: true
end
