require 'instapaper/connection'
require 'instapaper/request'
require 'instapaper/authentication'

module Instapaper
  # Wrapper for the Instapaper REST API
  class Client
    # @private
    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    alias_method :api_endpoint, :endpoint
    alias_method :api_version, :version

    # Creates a new API
    def initialize(options = {})
      options = Instapaper.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def endpoint_with_prefix
      api_endpoint + path_prefix
    end

    include Connection
    include Request
    include Authentication

    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'instapaper/client/account'
    require 'instapaper/client/user'
    require 'instapaper/client/bookmark'
    require 'instapaper/client/folder'

    include Instapaper::Client::Account
    include Instapaper::Client::User
    include Instapaper::Client::Bookmark
    include Instapaper::Client::Folder
  end
end
