require 'values'

module Instapaper
  class Highlight < Value.new(:type, :highlight_id, :bookmark_id, :text, :position, :time)
  end
end
