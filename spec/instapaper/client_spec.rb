require 'spec_helper'

describe Instapaper::Client do
  let(:client) { Instapaper::Client.new(consumer_key: 'CK', consumer_secret: 'CS', access_token: 'OT', access_token_secret: 'OS') }

  describe '#credentials' do
    it 'returns the credentials as hash' do
      expect(client.credentials).to be_a Hash
    end
  end

  describe '#credentials?' do
    it 'returns true when all credentials are present' do
      expect(client.credentials?).to be true
    end
  end

  describe '#consumer_credentials?' do
    it 'returns the consumer credentials as hash' do
      expect(client.consumer_credentials).to be_a Hash
    end
  end
end
