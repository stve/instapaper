require 'instapaper/struct'
require 'instapaper/types'

module Instapaper
  class Folder < Instapaper::Struct
    attribute? :title, Types::Coercible::String.optional.default(nil)
    attribute? :display_title, Types::Coercible::String.optional.default(nil)
    attribute? :sync_to_mobile, Types::Boolean.optional.default(nil)
    attribute? :folder_id, Types::Coercible::Integer.optional.default(nil)
    attribute? :position, Types::Coercible::String.optional.default(nil)
    attribute? :type, Types::Coercible::String.optional.default(nil)
    attribute? :slug, Types::Coercible::String.optional.default(nil)
  end
end
