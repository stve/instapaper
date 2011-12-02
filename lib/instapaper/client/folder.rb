module Instapaper
  class Client
    # Defines methods related to folders
    module Folder

      # List the account’s user-created folders.
      # @note This only includes organizational folders and does not include RSS-feed folders or starred-subscription folders
      def folders
        post('folders/list')
      end

      # Creates an organizational folder.
      # @param title [String] The title of the folder to create
      def add_folder(title)
        post('folders/add', :title => title)
      end

      # Deletes the folder and moves any articles in it to the Archive.
      # @param folder_id [String] The id of the folder.
      def delete_folder(folder_id)
        post('folders/delete', :folder_id => folder_id)
      end

      # Re-orders a user’s folders.
      # @param order [Array] An array of folder_id:position pairs joined by commas.
      # @example Ordering folder_ids 100, 200, and 300
      #   Instapaper.set_order(['100:1','200:2','300:3'])
      def set_order(order=[])
        post('folders/set_order', :order => order.join(','))
      end

    end
  end
end
