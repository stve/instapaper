module Instapaper
  # Custom error class for rescuing from all Instapaper errors
  class Error < StandardError
    # @return [Integer]
    attr_reader :code

    ServiceUnavailableError = Class.new(self)
    BookmarkError = Class.new(self)
    FolderError = Class.new(self)
    HighlightError = Class.new(self)
    OAuthError = Class.new(self)

    ERRORS = {
      401  => 'Unauthorized',
      1040 => 'Rate-limit exceeded',
      1041 => 'Premium account required',
      1042 => 'Application is suspended',
      1500 => 'Unexpected service error',
      1550 => 'Error generating text version of this URL',
    }

    BOOKMARK_ERRORS = {
      1220 => 'Domain requires full content to be supplied',
      1221 => 'Domain has opted out of Instapaper compatibility',
      1240 => 'Invalid URL specified',
      1241 => 'Invalid or missing bookmark_id',
      1242 => 'Invalid or missing folder_id',
      1243 => 'Invalid or missing progress',
      1244 => 'Invalid or missing progress_timestamp',
      1245 => 'Private bookmarks require supplied content',
      1250 => 'Unexpected error when saving bookmark',
    }

    FOLDER_ERRORS = {
      1250 => 'Invalid or missing title',
      1251 => 'User already has a folder with this title',
      1252 => 'Cannot add bookmarks to this folder',
    }

    HIGHLIGHT_ERRORS = {
      1600 => 'Cannot create highlight with empty text',
      1601 => 'Duplicate highlight',
    }

    CODES = [
      ERRORS,
      BOOKMARK_ERRORS,
      FOLDER_ERRORS,
      HIGHLIGHT_ERRORS,
    ].collect(&:keys).flatten

    # Create a new error from an HTTP response
    #
    # @param response [HTTP::Response]
    # @return [Instapaper::Error]
    def self.from_response(code, path)
      if ERRORS.keys.include?(code)
        new(ERRORS[code], code)
      else
        case path
        when /highlights/ then HighlightError.new(HIGHLIGHT_ERRORS[code], code)
        when /bookmarks/ then BookmarkError.new(BOOKMARK_ERRORS[code], code)
        when /folders/ then FolderError.new(FOLDER_ERRORS[code], code)
        else new('Unknown Error Code', code)
        end
      end
    end

    # Initializes a new Error object
    #
    # @param message [Exception, String]
    # @param code [Integer]
    # @return [Instapaper::Error]
    def initialize(message = '', code = nil)
      super(message)
      @code = code
    end
  end
end
