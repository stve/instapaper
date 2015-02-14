require 'instapaper/api'
require 'instapaper/http/utils'
require 'instapaper/version'

module Instapaper
  # Wrapper for the Instapaper REST API
  class Client
    include Instapaper::API
    include Instapaper::HTTP::Utils

    # An array of valid keys in the options hash when configuring a {Instapaper::API}
    VALID_OPTIONS_KEYS = [
      :consumer_key,
      :consumer_secret,
      :endpoint,
      :oauth_token,
      :oauth_token_secret,
      :proxy,
      :user_agent,
      :connection_options].freeze

    # By default, don't set an application key
    DEFAULT_CONSUMER_KEY = nil

    # By default, don't set an application secret
    DEFAULT_CONSUMER_SECRET = nil

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = 'https://www.instapaper.com'.freeze

    # By default, don't set a user oauth token
    DEFAULT_OAUTH_TOKEN = nil

    # By default, don't set a user oauth secret
    DEFAULT_OAUTH_TOKEN_SECRET = nil

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Instapaper Ruby Gem #{Instapaper::VERSION}".freeze

    DEFAULT_CONNECTION_OPTIONS = {}

    # @private
    attr_accessor :consumer_key
    attr_accessor :consumer_secret
    attr_accessor :endpoint
    attr_accessor :oauth_token
    attr_accessor :oauth_token_secret
    attr_accessor :proxy
    attr_accessor :user_agent
    attr_accessor :connection_options

    # Creates a new Instapaper::Client
    def initialize(options = {})
      reset
      options.keys.each do |key|
        send("#{key}=", options[key])
      end
    end

    # Authentication hash
    #
    # @return [Hash]
    def credentials
      {
        consumer_key: @consumer_key,
        consumer_secret: @consumer_secret,
        oauth_token: @oauth_token,
        oauth_token_secret: @oauth_token_secret,
      }
    end

    def consumer_tokens
      {
        consumer_key: @consumer_key,
        consumer_secret: @consumer_secret,
      }
    end

    # Check whether user is authenticated
    #
    # @return [Boolean]
    def authenticated?
      authentication.values.all?
    end

    private

    # Reset all configuration options to defaults
    def reset # rubocop:disable MethodLength
      @consumer_key       = DEFAULT_CONSUMER_KEY
      @consumer_secret    = DEFAULT_CONSUMER_SECRET
      @endpoint           = DEFAULT_ENDPOINT
      @oauth_token        = DEFAULT_OAUTH_TOKEN
      @oauth_token_secret = DEFAULT_OAUTH_TOKEN_SECRET
      @proxy              = DEFAULT_PROXY
      @user_agent         = DEFAULT_USER_AGENT
      @connection_options = DEFAULT_CONNECTION_OPTIONS
    end
  end
end
