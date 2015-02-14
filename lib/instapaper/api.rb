require 'instapaper/api/accounts'
require 'instapaper/api/bookmarks'
require 'instapaper/api/folders'
require 'instapaper/api/highlights'
require 'instapaper/api/oauth'

module Instapaper
  module API
    include Instapaper::API::Accounts
    include Instapaper::API::Bookmarks
    include Instapaper::API::Folders
    include Instapaper::API::Highlights
    include Instapaper::API::OAuth
  end
end
