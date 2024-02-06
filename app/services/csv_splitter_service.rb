# frozen_string_literal: true

class CsvSplitterService
  # TODO: I didnt have time to refactor this, not proud
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/AbcSize
  def split_in_chunks(file_path:, destination_folder:, chunk_size: 10_000, include_head: true)
    FileUtils.mkdir_p(destination_folder)
    read_count = 0
    current_file, head = nil
    file = File.open(file_path, 'r')
    file.advise(:sequential)
    ret = []

    file.each do |line|
      head = line if !head && include_head
      if (read_count % chunk_size).zero?
        current_file&.close
        current_chunk_name = "#{destination_folder}/#{File.basename(file_path, '.*')}_#{read_count / chunk_size}.csv"
        current_file = File.open(current_chunk_name, 'w')
        ret << current_chunk_name
        current_file << head if include_head && line != head
      end
      current_file << line
      read_count += 1
    end
    current_file.close
    file.close

    ret
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/AbcSize
end
