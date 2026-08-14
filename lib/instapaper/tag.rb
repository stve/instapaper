require 'instapaper/struct'
require 'instapaper/types'

module Instapaper
  class Tag < Instapaper::Struct
    attribute? :id, Types::Coercible::Integer.optional.default(nil)
    attribute? :name, Types::Coercible::String.optional.default(nil)
  end
end
