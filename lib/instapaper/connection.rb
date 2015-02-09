require 'faraday_middleware'
require 'faraday/response/raise_http_1xxx'

module Instapaper
  # @private
  module Connection
    private

    def connection(raw = false) # rubocop:disable AbcSize, CyclomaticComplexity, MethodLength, PerceivedComplexity
      merged_options = connection_defaults.merge(connection_options)

      Faraday.new(merged_options) do |builder|
        if authenticated?
          builder.use Faraday::Request::OAuth, authentication
        else
          builder.use Faraday::Request::OAuth, consumer_tokens
        end
        builder.use Faraday::Request::Multipart
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::Rashify unless raw
        builder.use Faraday::Response::ParseJson unless raw
        builder.use Faraday::Response::RaiseHttp1xxx
        builder.adapter(adapter)
      end
    end

    def connection_defaults
      {
        headers: {
          'Accept' => 'application/json',
          'User-Agent' => user_agent,
        },
        proxy: proxy,
        url: api_endpoint,
      }
    end
  end
end
