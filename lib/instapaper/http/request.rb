require 'addressable/uri'
require 'http'
require 'json'
require 'net/https'
require 'openssl'
require 'instapaper/error'
require 'instapaper/http/headers'

module Instapaper
  module HTTP
    class Request
      BASE_URL = 'https://www.instapaper.com'
      attr_accessor :client, :headers, :multipart, :options, :path,
                    :rate_limit, :request_method, :uri
      alias_method :verb, :request_method

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
        perform_request
      end

      private

      def perform_request
        raw = @options.delete(:raw)
        @headers = Instapaper::HTTP::Headers.new(@client, @request_method, @uri, @options).request_headers
        options_key = @request_method == :get ? :params : :form
        response = ::HTTP.with(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
        fail_if_error(response)
        raw ? response.to_s : symbolize_keys!(response.parse)
      end

      def fail_if_error(response)
        error = error(response.code)
        fail(error) if error
      end

      def error(code)
        if Instapaper::Error::CODES.index(code.to_i)
          Instapaper::Error.from_response(code, @path)
        end
      end

      def symbolize_keys!(object)
        if object.is_a?(Array)
          object.each_with_index do |val, index|
            object[index] = symbolize_keys!(val)
          end
        elsif object.is_a?(Hash)
          object.keys.each do |key|
            object[key.to_sym] = symbolize_keys!(object.delete(key))
          end
        end
        object
      end
    end
  end
end
