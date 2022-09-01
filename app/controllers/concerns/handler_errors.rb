# frozen_string_literal: true

# Response
module HandlerErrors
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :missing_params
  end

  def missing_params(error)
    render_json({ error: 'error', message: "missing_params: #{error.param}" }, status: :accepted)
  end
end
