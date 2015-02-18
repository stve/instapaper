require 'instapaper/http/qline_parser'

module Instapaper
  module API
    # Defines methods related to OAuth
    module OAuth
      # Gets an OAuth access token for a user.
      def access_token(username, password)
        response = perform_post_with_unparsed_response('/api/1/oauth/access_token', x_auth_username: username, x_auth_password: password, x_auth_mode: 'client_auth')
        QLineParser.parse(response)
      end
    end
  end
end
