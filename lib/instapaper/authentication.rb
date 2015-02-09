module Instapaper
  # @private
  module Authentication
    private

    # Authentication hash
    #
    # @return [Hash]
    def authentication
      {
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
        token: oauth_token,
        token_secret: oauth_token_secret,
      }
    end

    def consumer_tokens
      {
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
      }
    end

    # Check whether user is authenticated
    #
    # @return [Boolean]
    def authenticated?
      authentication.values.all?
    end
  end
end
