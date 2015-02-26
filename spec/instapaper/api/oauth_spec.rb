require 'spec_helper'

describe Instapaper::Client::OAuth do
  let(:client) { Instapaper::Client.new }

  describe '#token' do
    before do
      stub_post('/api/1/oauth/access_token').with(body: {x_auth_username: 'ohai', x_auth_password: 'p455w0rd', x_auth_mode: 'client_auth'})
        .to_return(body: fixture('access_token.txt'), headers: {content_type: 'text/plain; charset=utf-8'})
      stub_post('/api/1/oauth/access_token').with(body: {x_auth_username: 'inval1d', x_auth_password: 'cr3dentials', x_auth_mode: 'client_auth'})
        .to_return(body: fixture('invalid_credentials.txt'), headers: {content_type: 'text/plain; charset=utf-8'})
    end

    it 'gets the correct resource' do
      client.access_token('ohai', 'p455w0rd')
      expect(a_post('/api/1/oauth/access_token'))
        .to have_been_made
    end

    it 'returns the a hash containing an oauth token and secret' do
      tokens = client.access_token('ohai', 'p455w0rd')
      expect(tokens).to be_an Instapaper::Credentials
    end

    it 'returns a hash containing the error on invalid credentials' do
      expect {
        client.access_token('inval1d', 'cr3dentials')
      }.to raise_error(Instapaper::Error::OAuthError)
    end
  end
end
