require 'instapaper/http/request'
require 'instapaper/object'

module Instapaper
  module HTTP
    module Utils
      private

      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_post_with_objects(path, options, klass)
        perform_request_with_objects(:post, path, options, klass)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_request_with_objects(request_method, path, options, klass)
        perform_request(request_method, path, options).collect do |element|
          klass.new(element)
        end
      end

      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_post_with_object(path, options, klass)
        perform_request_with_object(:post, path, options, klass)
      end

      # @param request_method [Symbol]
      # @param path [String]
      # @param options [Hash]
      # @param klass [Class]
      def perform_request_with_object(request_method, path, options, klass)
        response = perform_request(request_method, path, options)
        response = response.is_a?(Array) ? response.first : response
        klass.new(response)
      end

      # @param path [String]
      # @param options [Hash]
      def perform_post_with_unparsed_response(path, options)
        perform_request(:post, path, options.merge(raw: true))
      end

      def perform_request(method, path, options)
        Instapaper::HTTP::Request.new(self, method, path, options).perform
      end
    end
  end
end
