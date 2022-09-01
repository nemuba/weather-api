# frozen_string_literal: true

# Response
module Response
  extend ActiveSupport::Concern

  def render_json(data, **attrs)
    render json: data, **attrs
  end
end
