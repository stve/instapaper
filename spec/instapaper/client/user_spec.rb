require 'spec_helper'

describe Instapaper::Client::User do
  before(:each) do
    @client = Instapaper::Client.new
  end

  describe '.access_token' do
    before do
      stub_post('oauth/access_token').with(body: {x_auth_username: 'ohai', x_auth_password: 'p455w0rd', x_auth_mode: 'client_auth'})
        .to_return(body: fixture('access_token.qline'), headers: {content_type: 'text/plain; charset=utf-8'})
      stub_post('oauth/access_token').with(body: {x_auth_username: 'inval1d', x_auth_password: 'cr3dentials', x_auth_mode: 'client_auth'})
        .to_return(body: fixture('invalid_credentials.qline'), headers: {content_type: 'text/plain; charset=utf-8'})
    end

    it 'should get the correct resource' do
      @client.access_token('ohai', 'p455w0rd')
      expect(a_post('oauth/access_token'))
        .to have_been_made
    end

    it 'should return the a hash containing an oauth token and secret' do
      tokens = @client.access_token('ohai', 'p455w0rd')
      expect(tokens).to be_a Hash
      expect(tokens.key?('oauth_token')).to be true
      expect(tokens.key?('oauth_token_secret')).to be true
    end

    it 'should return a hash containing the error on invalid credentials' do
      tokens = @client.access_token('inval1d', 'cr3dentials')
      expect(tokens).to be_a Hash
      expect(tokens.key?('error')).to be true
    end
  end
end
