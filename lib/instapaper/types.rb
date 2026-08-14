require 'dry-types'
require 'date'

module Instapaper
  module Types
    include Dry.Types()

    Boolean = Types::Params::Bool

    Timestamp = Types.Constructor(::DateTime) do |value|
      case value
      when ::DateTime then value
      when ::Date, ::Time then value.to_datetime
      else ::DateTime.strptime(value.to_s, '%s')
      end
    end
  end
end
