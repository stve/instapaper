require 'instapaper/api'
require 'instapaper/error'
require 'instapaper/version'
require 'faraday_middleware'
require 'faraday/response/parse_json'
require 'faraday/response/raise_http_1xxx'

module Instapaper
  # Wrapper for the Instapaper REST API
  class Client
    include Instapaper::API

    # An array of valid keys in the options hash when configuring a {Instapaper::API}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :consumer_key,
      :consumer_secret,
      :endpoint,
      :oauth_token,
      :oauth_token_secret,
      :proxy,
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
    attr_accessor :adapter
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

    private

    def connection(raw = false) # rubocop:disable AbcSize, CyclomaticComplexity, MethodLength, PerceivedComplexity
      merged_options = connection_defaults.merge(@connection_options)

      Faraday.new(merged_options) do |builder|
        if authenticated?
          builder.use Faraday::Request::OAuth, authentication
        else
          builder.use Faraday::Request::OAuth, consumer_tokens
        end
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        # builder.use Faraday::Response::Rashify unless raw
        builder.use Instapaper::API::Response::ParseJson unless raw
        builder.use Faraday::Response::RaiseHttp1xxx
        builder.adapter(adapter)
      end
    end

    def connection_defaults
      {
        headers: {
          'Accept' => 'application/json',
          'User-Agent' => @user_agent,
        },
        proxy: @proxy,
        url: @endpoint,
      }
    end

    # Perform an HTTP POST request
    def post(path, options = {}, raw = false)
      request(:post, path, options, raw)
    end

    # Perform an HTTP request
    def request(method, path, options, raw = false)
      response = connection(raw).send(method) do |request|
        request.path = path
        request.body = options unless options.empty?
      end
      raw ? response : response.body
    end
    alias_method :perform_request, :request

    # Authentication hash
    #
    # @return [Hash]
    def authentication
      {
        consumer_key: @consumer_key,
        consumer_secret: @consumer_secret,
        token: @oauth_token,
        token_secret: @oauth_token_secret,
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

    # Reset all configuration options to defaults
    def reset # rubocop:disable MethodLength
      @adapter            = DEFAULT_ADAPTER
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
