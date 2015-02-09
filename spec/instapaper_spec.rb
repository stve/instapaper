require 'spec_helper'

describe Instapaper do
  after do
    Instapaper.reset
  end

  describe '.respond_to?' do
    it 'takes an optional include private argument' do
      Instapaper.respond_to?(:client, true).should be true
    end
  end

  describe ".client" do
    it "should be a Instapaper::Client" do
      Instapaper.client.should be_a Instapaper::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Instapaper.adapter.should == Instapaper::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Instapaper.adapter = :typhoeus
      Instapaper.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      Instapaper.endpoint.should == Instapaper::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Instapaper.endpoint = 'http://tumblr.com/'
      Instapaper.endpoint.should == 'http://tumblr.com/'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Instapaper.user_agent.should == Instapaper::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Instapaper.user_agent = 'Custom User Agent'
      Instapaper.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".version" do
    it "should return the default version" do
      Instapaper.version.should == Instapaper::Configuration::DEFAULT_VERSION
    end
  end

  describe ".version=" do
    it "should set the user_agent" do
      Instapaper.version = '2'
      Instapaper.version.should == '2'
    end
  end

  describe ".configure" do

    Instapaper::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Instapaper.configure do |config|
          config.send("#{key}=", key)
          Instapaper.send(key).should == key
        end
      end
    end
  end

end
