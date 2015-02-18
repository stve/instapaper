require 'virtus'

module Instapaper
  class Highlight
    include Virtus.value_object

    values do
      attribute :type, String
      attribute :highlight_id, String
      attribute :bookmark_id, String
      attribute :text, String
      attribute :position, String
      attribute :time, String
    end
  end
end
