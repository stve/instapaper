require 'instapaper/version'

module Instapaper
  module Configuration
    # An array of valid keys in the options hash when configuring a {Instapaper::API}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :consumer_key,
      :consumer_secret,
      :endpoint,
      :oauth_token,
      :oauth_token_secret,
      :proxy,
      :version,
      :path_prefix,
      :user_agent,
      :connection_options].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = :net_http

    # By default, don't set an application key
    DEFAULT_CONSUMER_KEY = nil

    # By default, don't set an application secret
    DEFAULT_CONSUMER_SECRET = nil

    # The endpoint that will be used to connect if none is set
    DEFAULT_ENDPOINT = 'https://www.instapaper.com/'.freeze

    # The version of the API.
    DEFAULT_VERSION = '1'

    DEFAULT_PATH_PREFIX = 'api/' + DEFAULT_VERSION + '/'

    # By default, don't set a user oauth token
    DEFAULT_OAUTH_TOKEN = nil

    # By default, don't set a user oauth secret
    DEFAULT_OAUTH_TOKEN_SECRET = nil

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Instapaper Ruby Gem #{Instapaper::VERSION}".freeze

    DEFAULT_CONNECTION_OPTIONS = {}

    attr_accessor :adapter
    attr_accessor :consumer_key
    attr_accessor :consumer_secret
    attr_accessor :endpoint
    attr_accessor :oauth_token
    attr_accessor :oauth_token_secret
    attr_accessor :proxy
    attr_accessor :version
    attr_accessor :path_prefix
    attr_accessor :user_agent
    attr_accessor :connection_options

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      options = {}
      VALID_OPTIONS_KEYS.each { |k| options[k] = send(k) }
      options
    end

    # Reset all configuration options to defaults
    def reset # rubocop:disable MethodLength
      self.adapter            = DEFAULT_ADAPTER
      self.consumer_key       = DEFAULT_CONSUMER_KEY
      self.consumer_secret    = DEFAULT_CONSUMER_SECRET
      self.endpoint           = DEFAULT_ENDPOINT
      self.oauth_token        = DEFAULT_OAUTH_TOKEN
      self.oauth_token_secret = DEFAULT_OAUTH_TOKEN_SECRET
      self.proxy              = DEFAULT_PROXY
      self.user_agent         = DEFAULT_USER_AGENT
      self.version            = DEFAULT_VERSION
      self.path_prefix        = DEFAULT_PATH_PREFIX
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self
    end
  end
end
