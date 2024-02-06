# frozen_string_literal: true

describe Jobs::FileProcessorJob do
  describe 'working queue setup' do
    subject(:job) { described_class.perform_async }

    it 'enqueue a job' do
      expect { job }.to enqueue_sidekiq_job(described_class)
    end

    it 'is enqued on calculate_old_disbursements queue' do
      expect { job }.to enqueue_sidekiq_job.on('default')
    end

    it 'retries if fails' do
      expect(described_class).to be_retryable true
    end
  end

  describe '#perform' do
    before do
      double = instance_double(CsvSplitterService)
      allow(CsvSplitterService).to receive(:new).and_return(double)
      allow(double).to receive(:split_in_chunks).and_return(%w[file_1 file_2])
    end

    context 'when model_name is order' do
      subject(:job) { described_class.new.perform('/tmp/some', 'order') }

      context 'when model_name is merchant' do
        subject(:job) { described_class.new.perform('/tmp/some', 'merchant') }

        it 'schedules the job for each chunk' do
          expect(Jobs::MerchantImporterJob).to receive(:perform_in).with(0, 'file_1')
          expect(Jobs::MerchantImporterJob).to receive(:perform_in).with(0, 'file_2')

          job
        end
      end
    end
  end
end
