# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetJob, type: :job do
  let(:weather) { create(:weather) }

  it { is_expected.to be_processed_in :weather_request }
  it { is_expected.to be_expired_in 1.hour }
  it { is_expected.to be_retryable 5 }

  it 'is expected to be enqueued' do
    described_class.perform_async(weather.token)
    expect(described_class).to have_enqueued_sidekiq_job(weather.token)
  end

  it 'is expected to be enqueued in 5 minutes' do
    described_class.perform_in 5.minutes, weather.token
    expect(described_class).to have_enqueued_sidekiq_job(weather.token).in(5.minutes)
  end
end
