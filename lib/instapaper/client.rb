require 'instapaper/api'
require 'instapaper/http/utils'
require 'instapaper/version'

module Instapaper
  # Wrapper for the Instapaper REST API
  class Client
    include Instapaper::API
    include Instapaper::HTTP::Utils

    attr_accessor :access_token, :access_token_secret, :consumer_key, :consumer_secret, :proxy
    attr_writer :user_agent

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Instapaper::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    # @return [String]
    def user_agent
      @user_agent ||= "InstapaperRubyGem/#{Instapaper::VERSION}"
    end

    # Authentication hash
    #
    # @return [Hash]
    def credentials
      {
        consumer_key: @consumer_key,
        consumer_secret: @consumer_secret,
        access_token: @access_token,
        access_token_secret: @access_token_secret,
      }
    end

    # @return [Hash]
    def consumer_credentials
      {
        consumer_key: @consumer_key,
        consumer_secret: @consumer_secret,
      }
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end
  end
end
