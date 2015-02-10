require 'values'

module Instapaper
  class User < Value.new(:type, :user_id, :username)
  end
end
