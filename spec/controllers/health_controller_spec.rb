# frozen_string_literal: true

describe Controllers::HealthController, type: :controller do
  def app
    described_class.new
  end

  describe 'GET /' do
    it 'returns a health check' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to eq({ status: 'ok' }.to_json)
    end
  end
end
