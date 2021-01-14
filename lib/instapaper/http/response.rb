require 'json'
require 'instapaper/error'

module Instapaper
  module HTTP
    class Response
      attr_reader :response, :raw_format, :path

      # TODO: Change this to a keyword argument (needs a major version bump)
      def initialize(response, path, raw_format = false) # rubocop:disable Style/OptionalBooleanParameter
        @response = response
        @path = path
        @raw_format = raw_format
      end

      def body
        raw_format ? response.to_s : parsed
      end

      def valid?
        !error?
      end

      def error?
        fail_if_body_unparseable unless raw_format
        fail_if_body_contains_error
        fail_if_http_error
      end

      private

      def parsed
        @parsed ||= begin
          response.parse(:json)
        rescue StandardError
          response.body
        end
      end

      def fail_if_http_error
        return if response.status.ok?

        if Instapaper::Error::CODES.include?(response.status.code) # rubocop:disable Style/GuardClause
          raise Instapaper::Error.from_response(response.status.code, path)
        else
          raise Instapaper::Error, 'Unknown Error'
        end
      end

      def fail_if_body_unparseable
        response.parse(:json)
      rescue JSON::ParserError
        raise Instapaper::Error::ServiceUnavailableError
      end

      def fail_if_body_contains_error
        return unless parsed.is_a?(Array)
        return if parsed.empty?
        return unless parsed.first['type'] == 'error'

        raise Instapaper::Error.from_response(parsed.first['error_code'], @path)
      end
    end
  end
end
