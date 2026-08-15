require 'instapaper/struct'
require 'instapaper/types'
require 'instapaper/bookmark'
require 'instapaper/highlight'
require 'instapaper/user'

module Instapaper
  class BookmarkList < Instapaper::Struct
    include Enumerable

    attribute? :user, Instapaper::User.optional.default(nil)
    attribute? :bookmarks, Types::Array.of(Instapaper::Bookmark).default([].freeze)
    attribute? :highlights, Types::Array.of(Instapaper::Highlight).default([].freeze)
    attribute? :delete_ids, Types::Array.of(Types::Coercible::Integer).default([].freeze)

    def each(&)
      bookmarks.each(&)
    end
  end
end
