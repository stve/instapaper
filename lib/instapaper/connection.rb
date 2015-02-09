require 'faraday_middleware'
require 'faraday/response/raise_http_1xxx'

module Instapaper
  # @private
  module Connection
    private

    def connection(raw = false)
      merged_options = connection_options.merge(headers: {
                                                  'Accept' => 'application/json',
                                                  'User-Agent' => user_agent
                                                },
                                                proxy: proxy,
                                                ssl: { verify: false },
                                                url: api_endpoint)

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
  end
end
