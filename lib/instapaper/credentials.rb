require 'virtus'

module Instapaper
  class Credentials
    include Virtus.value_object

    values do
      attribute :oauth_token, String
      attribute :oauth_token_secret, String
    end
  end
end
