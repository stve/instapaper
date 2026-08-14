require 'instapaper/struct'
require 'instapaper/types'

module Instapaper
  class Highlight < Instapaper::Struct
    attribute? :type, Types::Coercible::String.optional.default(nil)
    attribute? :highlight_id, Types::Coercible::String.optional.default(nil)
    attribute? :bookmark_id, Types::Coercible::String.optional.default(nil)
    attribute? :text, Types::Coercible::String.optional.default(nil)
    attribute? :position, Types::Coercible::String.optional.default(nil)
    attribute? :time, Types::Coercible::String.optional.default(nil)
  end
end
