require 'addressable/uri'
require 'http'
require 'json'
require 'net/https'
require 'openssl'
require 'instapaper/http/headers'
require 'instapaper/http/response'

module Instapaper
  module HTTP
    class Request
      BASE_URL = 'https://www.instapaper.com'
      attr_accessor :client, :headers, :options, :path, :request_method, :uri

      # @param client [Instapaper::Client]
      # @param request_method [String, Symbol]
      # @param path [String]
      # @param options [Hash]
      # @return [Instapaper::HTTP::Request]
      def initialize(client, request_method, path, options = {})
        @client = client
        @request_method = request_method
        @uri = Addressable::URI.parse(path.start_with?('http') ? path : BASE_URL + path)
        @path = uri.path
        @options = options
      end

      # @return [Array, Hash]
      def perform
        raw = @options.delete(:raw)
        response = Instapaper::HTTP::Response.new(perform_request, path, raw)
        response.valid? && response.body
      end

      private

      def perform_request
        @headers = Instapaper::HTTP::Headers.new(@client, @request_method, @uri, @options).request_headers
        options_key = @request_method == :get ? :params : :form
        ::HTTP.headers(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
      end
    end
  end
end
