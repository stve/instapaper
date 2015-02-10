require 'values'

module Instapaper
  class Bookmark < Value.new(:type, :bookmark_id, :url, :title, :description, :time, :starred, :private_source, :hash, :progress, :progress_timestamp)
  end
end
