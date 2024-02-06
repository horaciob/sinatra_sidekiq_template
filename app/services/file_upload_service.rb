# frozen_string_literal: true

require 'tempfile'

class FileUploadService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    directory = "#{ENV.fetch('UPLOAD_FILE_FOLDER')}/originals"
    FileUtils.mkdir_p(directory)

    unique_filename = "#{SecureRandom.uuid}_#{params['file']['filename']}"
    target_file = File.join(directory, unique_filename)
    FileUtils.cp(params['file']['tempfile'].path, target_file)

    target_file
  end

  def valid_file?
    return false unless params['file'] &&
                        params['file']['type'] == 'text/csv' &&
                        params['file']['filename'] &&
                        params['file'].fetch('filename', '').end_with?('.csv')

    true
  end
end
