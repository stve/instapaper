require 'instapaper/struct'
require 'instapaper/types'

module Instapaper
  class User < Instapaper::Struct
    attribute? :username, Types::Coercible::String.optional.default(nil)
    attribute? :user_id, Types::Coercible::Integer.optional.default(nil)
    attribute? :type, Types::Coercible::String.optional.default(nil)
    attribute? :subscription_is_active, Types::Boolean.optional.default(nil)
  end
end
