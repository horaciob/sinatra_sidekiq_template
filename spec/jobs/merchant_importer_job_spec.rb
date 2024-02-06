# frozen_string_literal: true

describe Jobs::MerchantImporterJob do
  subject(:job) { described_class.perform_async }

  describe 'working queue setup' do
    it 'enqueue a job' do
      expect { job }.to enqueue_sidekiq_job(described_class)
    end

    it 'is enqued on orders queue' do
      expect { job }.to enqueue_sidekiq_job.on('merchant_importer')
    end

    it 'retries if fails' do
      expect(described_class).to be_retryable true
    end
  end

  describe '#perform' do
    context 'when success' do
      # id;reference;email;live_on;disbursement_frequency;minimum_monthly_fee
      # 86312006-4d7e-45c4-9c28-788f4aa68a62;padberg_group;info@padberg-group.com;2023-02-01;DAILY;0.0
      let(:filename) { 'spec/extras/single_merchant.csv' }

      before do
        described_class.new.perform(filename)
      end
    end
  end
end
