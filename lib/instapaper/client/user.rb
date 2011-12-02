module Instapaper
  class Client
    # Defines methods related to users
    module User

      # Gets an OAuth access token for a user.
      def access_token(username, password)
        response = post('oauth/access_token', { :x_auth_username => username, :x_auth_password => password, :x_auth_mode => "client_auth"}, true)
        Hash[*response.body.split("&").map {|part| part.split("=") }.flatten]
      end

    end
  end
end
