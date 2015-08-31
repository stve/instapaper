require 'virtus'

module Instapaper
  class User
    include Virtus.value_object

    values do
      attribute :username, String
      attribute :user_id, Integer
      attribute :type, String
      attribute :subscription_is_active, Axiom::Types::Boolean
    end
  end
end
