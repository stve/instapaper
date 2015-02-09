module Instapaper
  module API
    # Defines methods related to accounts
    module Account
      # Returns the currently logged in user.
      def verify_credentials
        post('/api/1/account/verify_credentials')
      end
    end
  end
end
