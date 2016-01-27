require 'spec_helper'

describe Instapaper::HTTP::Request do
  let(:client) { Instapaper::Client.new(consumer_key: 'CK', consumer_secret: 'CS', oauth_token: 'OT', oauth_token_secret: 'OS') }

  describe 'error handling' do
    context 'when receiving a non-200 response' do
      before do
        stub_post('/api/1.1/folders/list')
          .to_return(status: 503, body: '', headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'raises a ServerError' do
        expect { client.folders }.to raise_error(Instapaper::Error::ServerError)
      end
    end

    context 'when failing to parse json' do
      before do
        stub_post('/api/1.1/folders/list')
          .to_return(status: 200, body: '{"key":"value}', headers: {content_type: 'application/json; charset=utf-8'})
      end
      it 'raises a ServiceUnavailableError' do
        expect { client.folders }.to raise_error(Instapaper::Error::ServiceUnavailableError)
      end
    end
  end
end
