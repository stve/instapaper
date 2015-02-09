require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp1xxx < Response::Middleware # rubocop:disable Style/ClassAndModuleChildren
    def on_complete(env) # rubocop:disable AbcSize, CyclomaticComplexity, MethodLength
      case env[:status].to_i

      # general errors

      when 1040
        fail Instapaper::Error, error_message(env, 'Rate-limit exceeded.')
      when 1041
        fail Instapaper::Error, error_message(env, 'Subscription account required.')
      when 1042
        fail Instapaper::Error, error_message(env, 'Application is suspended.')

      # bookmark errors

      when 1220
        fail Instapaper::Error, error_message(env, 'Domain requires full content to be supplied.')
      when 1221
        fail Instapaper::Error, error_message(env, 'Domain has opted out of Instapaper compatibility.')
      when 1240
        fail Instapaper::Error, error_message(env, 'Invalid URL specified.')
      when 1241
        fail Instapaper::Error, error_message(env, 'Invalid or missing bookmark_id.')
      when 1242
        fail Instapaper::Error, error_message(env, 'Invalid or missing folder_id.')
      when 1243
        fail Instapaper::Error, error_message(env, 'Invalid or missing progress.')
      when 1244
        fail Instapaper::Error, error_message(env, 'Invalid or missing progress_timestamp.')
      when 1245
        fail Instapaper::Error, error_message(env, 'Private bookmarks require supplied content.')
      when 1250
        fail Instapaper::Error, error_message(env, 'Unexpected error when saving bookmark.')

      # folder errors

      when 1250
        fail Instapaper::Error, error_message(env, 'Invalid or missing title.')
      when 1251
        fail Instapaper::Error, error_message(env, 'User already has a folder with this title.')
      when 1252
        fail Instapaper::Error, error_message(env, 'Cannot add bookmarks to this folder.')

      # operational errors

      when 1500
        fail Instapaper::Error, error_message(env, 'Unexpected service error.')
      when 1550
        fail Instapaper::Error, error_message(env, 'Error generating text version of this URL.')
      end
    end

    private

    def error_message(env, body = nil)
      "#{env[:method].to_s.upcase} #{env[:url]}: #{[env[:status].to_s + ':', body].compact.join(' ')}."
    end
  end
end
