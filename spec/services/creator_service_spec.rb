# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Creator, type: :job do
  let(:attrs) { { token: SecureRandom.hex, location: Faker::Address.state } }

  describe '#call' do
    it 'success' do
      Creator.call(attrs)
      expect(GetJob.jobs.size).to eq(1)
      expect(GetJob).to have_enqueued_sidekiq_job(attrs[:token])
      expect(GetJob).to be_processed_in(:weather_request)
    end

    it 'error' do
      data = Creator.call({})
      expect(GetJob.jobs.size).to eq(0)
      expect(data).to have_key(:error)
      expect(data).to have_key(:message)
    end
  end

  describe '#show' do
    before do
      Creator.call(attrs)
    end

    it 'success' do
      data = Creator.show(attrs[:token])
      expect(data).to have_key('token')
      expect(data).to have_key('location')
      expect(data).to have_key('data')
    end

    it 'error' do
      data = Creator.show(nil)
      expect(data).to have_key(:error)
      expect(data).to have_key(:message)
    end
  end
end
