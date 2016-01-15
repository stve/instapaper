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
        response = ::HTTP.headers(@headers).public_send(@request_method, @uri.to_s, options_key => @options)
        fail_if_error(response, raw)
        raw ? response.to_s : parsed_response(response)
      end

      def fail_if_error(response, raw)
        fail_if_error_unparseable_response(response) unless raw
        fail_if_error_in_body(parsed_response(response))
        fail_if_error_response_code(response)
      end

      def fail_if_error_response_code(response)
        fail Instapaper::Error::ServiceUnavailableError if response.status != 200
      end

      def fail_if_error_unparseable_response(response)
        response.parse(:json)
      rescue JSON::ParserError
        raise Instapaper::Error::ServiceUnavailableError
      end

      def fail_if_error_in_body(response)
        error = error(response)
        fail(error) if error
      end

      def error(response)
        return unless response.is_a?(Array)
        return unless response.size > 0
        return unless response.first['type'] == 'error'

        Instapaper::Error.from_response(response.first['error_code'], @path)
      end

      def parsed_response(response)
        @parsed_response ||= begin
          response.parse(:json)
        rescue
          response.body
        end
      end
    end
  end
end
