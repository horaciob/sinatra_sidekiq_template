# frozen_string_literal: true

describe Controllers::MerchantsController, type: :controller do
  def app
    described_class.new
  end

  let(:response_json) { JSON.parse(last_response.body) }
  let(:headers) { { 'CONTENT_TYPE' => 'application/json' } }
  let(:valid_params) do
    {}
  end

  describe 'GET /' do
    it 'returns a list of merchants' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(response_json).to be_an(Array)
    end
  end
end
