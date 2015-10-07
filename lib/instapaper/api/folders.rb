require 'instapaper/folder'

module Instapaper
  module API
    # Defines methods related to folders
    module Folders
      # List the account's user-created folders.
      # @note This only includes organizational folders and does not include RSS-feed folders or starred-subscription folders
      def folders
        perform_post_with_objects('/api/1.1/folders/list', {}, Instapaper::Folder)
      end

      # Creates an organizational folder.
      # @param title [String] The title of the folder to create
      def add_folder(title)
        perform_post_with_object('/api/1.1/folders/add', {title: title}, Instapaper::Folder)
      end

      # Deletes the folder and moves any articles in it to the Archive.
      # @param folder_id [String] The id of the folder.
      def delete_folder(folder_id)
        perform_post_with_unparsed_response('/api/1.1/folders/delete', folder_id: folder_id)
        true
      end

      # Re-orders a user's folders.
      # @param order [Array] An array of folder_id:position pairs joined by commas.
      # @example Ordering folder_ids 100, 200, and 300
      #   Instapaper.set_order(['100:1','200:2','300:3'])
      def set_order(order = []) # rubocop:disable Style/AccessorMethodName
        perform_post_with_objects('/api/1.1/folders/set_order', {order: order.join(',')}, Instapaper::Folder)
      end
    end
  end
end
