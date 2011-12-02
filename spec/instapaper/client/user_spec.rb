require 'spec_helper'

describe Instapaper::Client::User do
  before(:each) do
    @client = Instapaper::Client.new
  end

  describe '.access_token' do
    before do
      stub_post("oauth/access_token").with(:body => { :x_auth_username => 'ohai', :x_auth_password => 'p455w0rd', :x_auth_mode => 'client_auth'}).
        to_return(:body => fixture("access_token.qline"), :headers => {:content_type => "text/plain; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.access_token('ohai', 'p455w0rd')
      a_post("oauth/access_token").
        should have_been_made
    end

    it "should return the a hash containing an oauth token and secret" do
      tokens = @client.access_token('ohai', 'p455w0rd')
      tokens.should be_a Hash
      tokens.key?('oauth_token').should be_true
      tokens.key?('oauth_token_secret').should be_true
    end
  end

end
