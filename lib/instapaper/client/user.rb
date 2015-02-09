module Instapaper
  class Client
    # Defines methods related to users
    module User
      # Gets an OAuth access token for a user.
      def access_token(username, password)
        response = post('oauth/access_token', {x_auth_username: username, x_auth_password: password, x_auth_mode: 'client_auth'}, true)
        params = response.body.split('&')
        values = params.map { |part| part.split('=') }.flatten
        if values.length == 1
          values.unshift('error')
        end
        Hash[*values]
      end
    end
  end
end
