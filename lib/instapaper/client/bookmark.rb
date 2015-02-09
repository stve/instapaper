module Instapaper
  class Client
    # Defines methods related to bookmarks
    module Bookmark
      # Lists the user's unread bookmarks, and can also synchronize reading positions.
      # @option limit: Optional. A number between 1 and 500, default 25.
      # @option folder_id: Optional. Possible values are unread (default), starred, archive, or a folder_id value from /api/1/folders/list.
      # @option have: Optional. A concatenation of bookmark_id values that the client already has from the specified folder. See below.
      def bookmarks(options = {})
        post('bookmarks/list', options)[2..-1]
      end

      # Updates the user's reading progress on a single article.
      # @param bookmark_id [String] The id of the bookmark to update.
      # @param progress [Float] The user's progress, as a floating-point number between 0.0 and 1.0, defined as the top edge of the user's current viewport, expressed as a percentage of the article's total length.
      # @param progress_timestamp [Integer] The Unix timestamp value of the time that the progress was recorded.
      def update_read_progress(bookmark_id, progress, progress_timestamp = Time.now)
        post('bookmarks/update_read_progress', bookmark_id: bookmark_id, progress: progress, progress_timestamp: progress_timestamp.to_i).first
      end

      # Adds a new unread bookmark to the user's account.
      # @param url [String] The url of the bookmark.
      def add_bookmark(url, options = {})
        post('bookmarks/add', options.merge(url: url)).first
      end

      # Permanently deletes the specified bookmark.
      # This is NOT the same as Archive. Please be clear to users if you're going to do this.
      # @param bookmark_id [String] The id of the bookmark.
      def delete_bookmark(bookmark_id)
        post('bookmarks/delete', bookmark_id: bookmark_id)
      end

      # Stars the specified bookmark.
      # @param bookmark_id [String] The id of the bookmark.
      def star(bookmark_id)
        post('bookmarks/star', bookmark_id: bookmark_id).first
      end
      alias_method :star_bookmark, :star

      # Un-stars the specified bookmark.
      # @param bookmark_id [String] The id of the bookmark.
      def unstar(bookmark_id)
        post('bookmarks/unstar', bookmark_id: bookmark_id).first
      end
      alias_method :unstar_bookmark, :unstar

      # Moves the specified bookmark to the Archive.
      # @param bookmark_id [String] The id of the bookmark.
      def archive(bookmark_id)
        post('bookmarks/archive', bookmark_id: bookmark_id).first
      end
      alias_method :archive_bookmark, :archive

      # Moves the specified bookmark to the top of the Unread folder.
      # @param bookmark_id [String] The id of the bookmark.
      def unarchive(bookmark_id)
        post('bookmarks/unarchive', bookmark_id: bookmark_id).first
      end
      alias_method :unarchive_bookmark, :unarchive

      # Moves the specified bookmark to a user-created folder.
      # @param bookmark_id [String] The id of the bookmark.
      # @param folder_id [String] The id of the folder to move the bookmark to.
      def move(bookmark_id, folder_id)
        post('bookmarks/move', bookmark_id: bookmark_id, folder_id: folder_id).first
      end
      alias_method :move_bookmark, :move

      # Returns the specified bookmark's processed text-view HTML, which is
      # always text/html encoded as UTF-8.
      # @param bookmark_id [String] The id of the bookmark.
      def text(bookmark_id)
        post('bookmarks/get_text', {bookmark_id: bookmark_id}, true).body
      end
      alias_method :get_text, :text
    end
  end
end
