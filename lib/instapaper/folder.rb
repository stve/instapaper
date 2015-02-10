require 'values'

module Instapaper
  class Folder < Value.new(:type, :folder_id, :title, :sync_to_mobile, :position)
  end
end
