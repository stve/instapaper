require 'instapaper/credentials'
require 'instapaper/http/qline_parser'

module Instapaper
  module API
    # Defines methods related to OAuth
    module OAuth
      # Gets an OAuth access token for a user.
      def access_token(username, password)
        response = perform_post_with_unparsed_response('/api/1.1/oauth/access_token', x_auth_username: username, x_auth_password: password, x_auth_mode: 'client_auth')
        parsed_response = QLineParser.parse(response)
        fail Instapaper::Error::OAuthError, parsed_response['error'] if parsed_response.key?('error')
        Instapaper::Credentials.new(parsed_response)
      end
    end
  end
end
