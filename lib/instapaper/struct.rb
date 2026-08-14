require 'dry-struct'

module Instapaper
  class Struct < Dry::Struct
    transform_keys(&:to_sym)
  end
end
