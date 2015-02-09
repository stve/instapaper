require 'spec_helper'

describe Instapaper do
  after do
    Instapaper.reset
  end

  describe '.respond_to?' do
    it 'takes an optional include private argument' do
      expect(Instapaper.respond_to?(:client, true)).to be true
    end
  end

  describe ".client" do
    it "should be a Instapaper::Client" do
      expect(Instapaper.client).to be_a Instapaper::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      expect(Instapaper.adapter).to eq(Instapaper::Configuration::DEFAULT_ADAPTER)
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Instapaper.adapter = :typhoeus
      expect(Instapaper.adapter).to eq(:typhoeus)
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      expect(Instapaper.endpoint).to eq(Instapaper::Configuration::DEFAULT_ENDPOINT)
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Instapaper.endpoint = 'http://tumblr.com/'
      expect(Instapaper.endpoint).to eq('http://tumblr.com/')
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      expect(Instapaper.user_agent).to eq(Instapaper::Configuration::DEFAULT_USER_AGENT)
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Instapaper.user_agent = 'Custom User Agent'
      expect(Instapaper.user_agent).to eq('Custom User Agent')
    end
  end

  describe ".version" do
    it "should return the default version" do
      expect(Instapaper.version).to eq(Instapaper::Configuration::DEFAULT_VERSION)
    end
  end

  describe ".version=" do
    it "should set the user_agent" do
      Instapaper.version = '2'
      expect(Instapaper.version).to eq('2')
    end
  end

  describe ".configure" do

    Instapaper::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Instapaper.configure do |config|
          config.send("#{key}=", key)
          expect(Instapaper.send(key)).to eq(key)
        end
      end
    end
  end

end
