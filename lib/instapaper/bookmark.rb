require 'virtus'

module Instapaper
  class Bookmark
    include Virtus.value_object

    values do
      attribute :type, String
      attribute :bookmark_id, String
      attribute :url, String
      attribute :title, String
      attribute :description, String
      attribute :time, String
      attribute :starred, String
      attribute :private_source, String
      attribute :hash, String
      attribute :progress, String
      attribute :progress_timestamp, String
    end
  end
end
