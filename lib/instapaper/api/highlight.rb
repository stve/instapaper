require 'instapaper/highlight'

module Instapaper
  module API
    # Defines methods related to highlights
    module Highlight
      # List highlights for a bookmark
      def highlights(bookmark_id)
        perform_post_with_objects("/api/1.1/bookmarks/#{bookmark_id}/highlights", {}, Instapaper::Highlight)
      end

      # Create a new highlight
      # @note Non-subscribers are limited to 5 highlights per month.
      # @param bookmark_id [String, Integer]
      # @param options [Hash]
      # @option options [String] :text The text for the highlight (HTML tags in text parameter should be unescaped.)
      # @option options [String, Integer] :posiiton The 0-indexed position of text in the content. Defaults to 0.
      # @return [Instapaper::Highlight]
      def highlight(bookmark_id, options = {})
        perform_post_with_object("/api/1.1/bookmarks/#{bookmark_id}/highlight", options, Instapaper::Highlight)
      end

      # Delete a highlight
      # @param highlight_id [String, Integer]
      # @return [Boolean]
      def delete_highlight(highlight_id, options = {})
        perform_post_with_empty_response("/api/1.1/highlights/#{highlight_id}/delete", options)
        true
      end
    end
  end
end
