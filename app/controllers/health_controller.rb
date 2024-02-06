# frozen_string_literal: true

module Controllers
  class HealthController < BaseController
    # INDEX
    get '/' do
      json({ status: 'ok' })
    end
  end
end
