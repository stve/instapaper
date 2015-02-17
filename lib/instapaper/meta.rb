require 'virtus'

module Instapaper
  class Meta
    include Virtus.value_object

    values do
      attribute :type, String
    end
  end
end
