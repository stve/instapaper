require 'instapaper/bookmark'
require 'instapaper/highlight'
require 'instapaper/user'

module Instapaper
  class BookmarkList
    include Virtus.value_object

    values do
      attribute :user, Instapaper::User
      attribute :bookmarks, Array[Instapaper::Bookmark]
      attribute :highlights, Array[Instapaper::Highlight]
      attribute :delete_ids, Array[Integer]
    end

    def each(&block)
      bookmarks.each(&block)
    end
  end
end
