require 'instapaper/struct'
require 'instapaper/types'
require 'instapaper/tag'

module Instapaper
  class Bookmark < Instapaper::Struct
    attribute? :instapaper_hash, Types::Coercible::String.optional.default(nil)
    attribute? :description, Types::Coercible::String.optional.default(nil)
    attribute? :bookmark_id, Types::Coercible::Integer.optional.default(nil)
    attribute? :private_source, Types::Coercible::String.optional.default(nil)
    attribute? :title, Types::Coercible::String.optional.default(nil)
    attribute? :url, Types::Coercible::String.optional.default(nil)
    attribute? :progress_timestamp, Types::Timestamp.optional.default(nil)
    attribute? :time, Types::Timestamp.optional.default(nil)
    attribute? :progress, Types::Coercible::String.optional.default(nil)
    attribute? :starred, Types::Coercible::String.optional.default(nil)
    attribute? :type, Types::Coercible::String.optional.default(nil)
    attribute? :tags, Types::Array.of(Instapaper::Tag).default([].freeze)
  end
end
