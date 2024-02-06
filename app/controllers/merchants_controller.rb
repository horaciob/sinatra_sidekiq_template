# frozen_string_literal: true

module Controllers
  class MerchantsController < BaseController
    # INDEX
    get '/' do
      json ::Merchant.all
    end
  end
end
