require 'spec_helper'

describe Instapaper::Client::Account do
  before(:each) do
    @client = Instapaper::Client.new
  end

  describe '.verify_credentials' do
    before do
      stub_post("account/verify_credentials").
        to_return(:body => fixture("verify_credentials.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      @client.verify_credentials
      a_post("account/verify_credentials").
        should have_been_made
    end

    it "should return the user" do
      user = @client.verify_credentials.first
      user.should be_a Hashie::Rash
      user.username.should == 'TestUserOMGLOL'
    end
  end

end