require 'virtus'
require 'instapaper/tag'

module Instapaper
  class Bookmark
    include Virtus.value_object

    values do
      attribute :instapaper_hash, String
      attribute :description, String
      attribute :bookmark_id, Integer
      attribute :private_source, String
      attribute :title, String
      attribute :url, String
      attribute :progress_timestamp, DateTime
      attribute :time, DateTime
      attribute :progress, String
      attribute :starred, String
      attribute :type, String
      attribute :tags, Array[Instapaper::Tag]
    end
  end
end
