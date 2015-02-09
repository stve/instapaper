module Instapaper
  class Client
    # Defines methods related to accounts
    module Account
      # Returns the currently logged in user.
      def verify_credentials
        post('account/verify_credentials')
      end
    end
  end
end
