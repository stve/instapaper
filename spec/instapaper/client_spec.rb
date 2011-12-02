require 'spec_helper'

describe Instapaper::Client do

  before do
    @options = { :adapter => :em_synchrony, :user_agent => 'Instapaper::Client spec' }
    @keys = Instapaper::Configuration::VALID_OPTIONS_KEYS
  end

  describe '.new' do
    before(:each) do
      @keys.each do |key|
        Instapaper.send("#{key}=", key)
      end
    end

    after do
      Instapaper.reset
    end

    context 'with module configuration' do
      it "should inherit module configuration" do
        api = Instapaper::Client.new
        @keys.each do |key|
          api.send(key).should eq(key)
        end
      end
    end

    context 'with class configuration' do
      context "during initialization" do
        it "should override module configuration" do
          api = Instapaper::Client.new(@options)
          @keys.each do |key|
            h = @options.has_key?(key) ? @options : Instapaper.options
            api.send(key).should eq(h[key])
          end
        end
      end

      context "after initialization" do
        it "should override module configuration after initialization" do
          api = Instapaper::Client.new
          @options.each do |key, value|
            api.send("#{key}=", value)
          end
          @keys.each do |key|
            h = @options.has_key?(key) ? @options : Instapaper.options
            api.send(key).should eq(h[key])
          end
        end
      end
    end
  end

  describe '.endpoint_with_prefix' do
    before(:each) do
      @client = Instapaper::Client.new
    end

    it 'should return the ' do
      @client.endpoint_with_prefix.should == Instapaper.endpoint + Instapaper.path_prefix
    end
  end
end