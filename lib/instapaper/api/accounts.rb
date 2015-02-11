require 'instapaper/user'

module Instapaper
  module API
    # Defines methods related to accounts
    module Accounts
      # Returns the currently logged in user.
      def verify_credentials
        perform_post_with_object('/api/1/account/verify_credentials', {}, Instapaper::User)
      end
    end
  end
end
