module Instapaper
  # Custom error class for rescuing from all Instapaper errors
  class Error < StandardError
    # @return [Integer]
    attr_reader :code

#     RateLimitExceeded = Class.new(self)
#     PremiumAccountRequired = Class.new(self)
#     SuspendedApplication = Class.new(self)
#
# # 1040: Rate-limit exceeded
# # 1041: Premium account required
# # 1042: Application is suspended
#
#     BookmarkError = Class.new(self)
#
# Bookmark errors:
#
# 1220: Domain requires full content to be supplied
# 1221: Domain has opted out of Instapaper compatibility
# 1240: Invalid URL specified
# 1241: Invalid or missing bookmark_id
# 1242: Invalid or missing folder_id
# 1243: Invalid or missing progress
# 1244: Invalid or missing progress_timestamp
# 1245: Private bookmarks require supplied content
# 1250: Unexpected error when saving bookmark
# Folder errors:
#
# 1250: Invalid or missing title
# 1251: User already has a folder with this title
# 1252: Cannot add bookmarks to this folder
# Operational errors:
#
# 1500: Unexpected service error
# 1550: Error generating text version of this URL
# Highlight Errors:
#
# 1600: Cannot create highlight with empty text
# 1601: Duplicate highlight

  end
end
