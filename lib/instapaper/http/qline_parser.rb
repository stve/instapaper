module Instapaper
  class QLineParser
    def self.parse(response)
      values = response.split('&').map { |part| part.split('=') }.flatten
      values.unshift('error') if values.length == 1
      Hash[*values]
    end
  end
end
