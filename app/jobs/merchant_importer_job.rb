# frozen_string_literal: true

require 'csv'
module Jobs
  MERCH_SETTINGS_HEADER = %w[live_on].freeze
  MERCH_HEADERS = %w[id reference email].freeze

  class MerchantImporterJob
    include Sidekiq::Job
    sidekiq_options queue: :merchant_importer

    def perform(filename)
      import(filename)
      puts "Finish processing #{filename}"
    end

    private

    def import(filename)
      CSV.foreach(filename, headers: true, col_sep: ';') do |data|
        create_merchant(data)
        create_merchant_settings(data)
      end
    end

    def create_merchant(data)
      Merchant.create!(data.to_h.slice(*MERCH_HEADERS))
    end

    def create_merchant_settings(data)
      setting = build_merchant_setting_params(data)
      m = MerchantSetting.build(setting)
      m.fill_week_day
      m.save!
    end

    def build_merchant_setting_params(data)
      frequency = MerchantSetting.disbursement_frequencies[data['disbursement_frequency'].downcase]
      setting = data.to_h.slice(*MERCH_SETTINGS_HEADER)
      setting.merge!({ 'merchant_id' => data['id'],
                       'live_on' => Date.parse(data['live_on']),
                       'disbursement_frequency' => frequency,
                       'minimum_fee' => (data['minimum_monthly_fee'].to_f * 100).to_i })
      setting
    end
  end
end
