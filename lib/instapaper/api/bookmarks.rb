require 'instapaper/bookmark'

module Instapaper
  module API
    # Defines methods related to bookmarks
    module Bookmarks
      # Lists the user's unread bookmarks, and can also synchronize reading positions.
      # @option limit: Optional. A number between 1 and 500, default 25.
      # @option folder_id: Optional. Possible values are unread (default), starred, archive, or a folder_id value from /api/1/folders/list.
      # @option have: Optional. A concatenation of bookmark_id values that the client already has from the specified folder. See below.
      def bookmarks(options = {})
        perform_post_with_objects('/api/1/bookmarks/list', options, Instapaper::Object)[2..-1]
      end

      # Updates the user's reading progress on a single article.
      # @param bookmark_id [String] The id of the bookmark to update.
      # @param progress [Float] The user's progress, as a floating-point number between 0.0 and 1.0, defined as the top edge of the user's current viewport, expressed as a percentage of the article's total length.
      # @param progress_timestamp [Integer] The Unix timestamp value of the time that the progress was recorded.
      def update_read_progress(bookmark_id, progress, progress_timestamp = Time.now)
        perform_post_with_object('/api/1/bookmarks/update_read_progress', {bookmark_id: bookmark_id, progress: progress, progress_timestamp: progress_timestamp.to_i}, Instapaper::Bookmark)
      end

      # Adds a new unread bookmark to the user's account.
      # @param url [String] The url of the bookmark.
      def add_bookmark(url, options = {})
        perform_post_with_object('/api/1/bookmarks/add', options.merge(url: url), Instapaper::Bookmark)
      end

      # Permanently deletes the specified bookmark.
      # This is NOT the same as Archive. Please be clear to users if you're going to do this.
      # @param bookmark_id [String] The id of the bookmark.
      def delete_bookmark(bookmark_id)
        perform_post_with_objects('/api/1/bookmarks/delete', {bookmark_id: bookmark_id}, Array)
      end

      # Stars the specified bookmark.
      # @param bookmark_id [String] The id of the bookmark.
      def star_bookmark(bookmark_id)
        perform_post_with_object('/api/1/bookmarks/star', {bookmark_id: bookmark_id}, Instapaper::Bookmark)
      end

      # Un-stars the specified bookmark.
      # @param bookmark_id [String] The id of the bookmark.
      def unstar_bookmark(bookmark_id)
        perform_post_with_object('/api/1/bookmarks/unstar', {bookmark_id: bookmark_id}, Instapaper::Bookmark)
      end

      # Moves the specified bookmark to the Archive.
      # @param bookmark_id [String] The id of the bookmark.
      def archive_bookmark(bookmark_id)
        perform_post_with_object('/api/1/bookmarks/archive', {bookmark_id: bookmark_id}, Instapaper::Bookmark)
      end

      # Moves the specified bookmark to the top of the Unread folder.
      # @param bookmark_id [String] The id of the bookmark.
      def unarchive_bookmark(bookmark_id)
        perform_post_with_object('/api/1/bookmarks/unarchive', {bookmark_id: bookmark_id}, Instapaper::Bookmark)
      end

      # Moves the specified bookmark to a user-created folder.
      # @param bookmark_id [String] The id of the bookmark.
      # @param folder_id [String] The id of the folder to move the bookmark to.
      def move_bookmark(bookmark_id, folder_id)
        perform_post_with_object('/api/1/bookmarks/move', {bookmark_id: bookmark_id, folder_id: folder_id}, Instapaper::Bookmark)
      end

      # Returns the specified bookmark's processed text-view HTML, which is
      # always text/html encoded as UTF-8.
      # @param bookmark_id [String] The id of the bookmark.
      def get_text(bookmark_id)
        perform_post_with_unparsed_response('/api/1/bookmarks/get_text', bookmark_id: bookmark_id)
      end
    end
  end
end
