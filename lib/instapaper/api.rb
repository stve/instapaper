require 'instapaper/api/account'
require 'instapaper/api/bookmark'
require 'instapaper/api/folder'
require 'instapaper/api/highlight'
require 'instapaper/api/user'

module Instapaper
  module API
    include Instapaper::API::Account
    include Instapaper::API::Bookmark
    include Instapaper::API::Folder
    include Instapaper::API::Highlight
    include Instapaper::API::User
  end
end
