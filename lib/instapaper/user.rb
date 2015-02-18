require 'virtus'

module Instapaper
  class User
    include Virtus.value_object

    values do
      attribute :type, String
      attribute :user_id, String
      attribute :username, String
      attribute :subscription_is_active, String
    end
  end
end
