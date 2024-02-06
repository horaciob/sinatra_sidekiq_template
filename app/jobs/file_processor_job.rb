# frozen_string_literal: true

module Jobs
  class FileProcessorJob
    include Sidekiq::Job
    sidekiq_options queue: :default

    CHUNK_SIZE = 1_000
    AVAILABLE_JOBS = { merchant: Jobs::MerchantImporterJob }.freeze

    def perform(file_path, model_name)
      return false unless AVAILABLE_JOBS.include?(model_name.to_sym)

      files = chunk_file(file_path, model_name)

      job = AVAILABLE_JOBS[model_name.to_sym]
      files.each do |file|
        job.perform_in(0, file)
      end
    end

    private

    def chunk_file(file_path, model_name)
      destination_folder = "#{ENV.fetch('UPLOAD_FILE_FOLDER')}/#{model_name}_#{SecureRandom.uuid}"
      CsvSplitterService.new.split_in_chunks(file_path:,
                                             chunk_size: CHUNK_SIZE,
                                             destination_folder:)
    end
  end
end
