require 'virtus'

module Instapaper
  class Folder
    include Virtus.value_object

    values do
      attribute :title, String
      attribute :display_title, String
      attribute :sync_to_mobile, Axiom::Types::Boolean
      attribute :folder_id, Integer
      attribute :position, String
      attribute :type, String
      attribute :slug, String
    end
  end
end
