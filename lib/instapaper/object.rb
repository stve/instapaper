require 'instapaper/meta'

module Instapaper
  class Object
    def self.with(data)
      type = data[:type]
      type[0] = type[0].upcase
      Instapaper.const_get(type).with(data)
    end
  end
end
