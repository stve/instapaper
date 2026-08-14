require 'instapaper/struct'
require 'instapaper/types'

module Instapaper
  class Credentials < Instapaper::Struct
    attribute? :oauth_token, Types::Coercible::String.optional.default(nil)
    attribute? :oauth_token_secret, Types::Coercible::String.optional.default(nil)
  end
end
