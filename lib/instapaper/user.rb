require 'values'

module Instapaper
  class User < Value.new(:type, :user_id, :username, :subscription_is_active)
  end
end
