require 'instapaper/utils'

module Instapaper
  class QLineParser
    extend Instapaper::Utils

    def self.parse(response)
      values = response.split('&').map { |part| part.split('=') }.flatten
      values.unshift('error') if values.length == 1
      symbolize_keys!(Hash[*values])
    end
  end
end
