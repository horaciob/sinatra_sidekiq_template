# frozen_string_literal: true

describe FileUploadService do
  describe 'call' do
    let(:upload_file_folder) { '/my/upload/folder' }
    let(:file_params) do
      {
        'file' => {
          'filename' => 'example.txt',
          'tempfile' => Tempfile.new('example.txt')
        }
      }
    end
    let(:service_instance) { described_class.new(file_params) }

    before do
      allow(ENV).to receive(:fetch).with('UPLOAD_FILE_FOLDER').and_return(upload_file_folder)
    end

    it 'copies the file to the originals folder with a unique filename' do
      allow(SecureRandom).to receive(:uuid).and_return('unique_uuid')
      allow(FileUtils).to receive(:mkdir_p)
      allow(FileUtils).to receive(:cp)

      expect(FileUtils).to receive(:mkdir_p).with("#{upload_file_folder}/originals")
      expect(FileUtils).to receive(:cp).with(file_params['file']['tempfile'].path,
                                             "#{upload_file_folder}/originals/unique_uuid_example.txt")
      result = service_instance.call
      expect(result).to eq("#{upload_file_folder}/originals/unique_uuid_example.txt")
    end
  end

  describe '#valid_file?' do
    subject(:uploader) { described_class.new(params) }

    let(:params) do
      {
        'file' => {
          'type' => 'text/csv',
          'filename' => 'pepe.csv'
        }
      }
    end

    context 'when success' do
      let(:params) do
        {
          'file' => {
            'type' => 'text/csv',
            'filename' => 'pepe.csv'
          }
        }
      end

      it 'returns true' do
        expect(uploader.valid_file?).to be true
      end
    end

    context 'when false' do
      context 'when has wrong type' do
        before do
          params['file']['type'] = 'something'
        end

        it 'returns false' do
          expect(uploader.valid_file?).to be false
        end
      end

      context 'when extension is not valid' do
        before do
          params['file']['filename'] = 'something.jpeg'
        end

        it 'returns false' do
          expect(uploader.valid_file?).to be false
        end
      end
    end
  end
end
