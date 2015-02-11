require 'spec_helper'

describe Instapaper::Client::Accounts do
  let(:client) { Instapaper::Client.new }

  describe '.verify_credentials' do
    before do
      stub_post('/api/1/account/verify_credentials')
        .to_return(body: fixture('verify_credentials.json'), headers: {content_type: 'application/json; charset=utf-8'})
    end

    it 'should get the correct resource' do
      client.verify_credentials
      expect(a_post('/api/1/account/verify_credentials'))
        .to have_been_made
    end

    it 'should return the user' do
      user = client.verify_credentials
      expect(user).to be_a Instapaper::User
    end
  end
end
