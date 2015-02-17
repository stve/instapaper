require 'instapaper/meta'

module Instapaper
  class Object
    def self.new(data)
      type = data[:type]
      type[0] = type[0].upcase
      Instapaper.const_get(type).new(data)
    end
  end
end
