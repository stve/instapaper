require 'virtus'

module Instapaper
  class Folder
    include Virtus.value_object

    values do
      attribute :type, String
      attribute :folder_id, String
      attribute :title, String
      attribute :sync_to_mobile, String
      attribute :position, String
    end
  end
end
