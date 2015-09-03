require 'instapaper'

credentials = {
  consumer_key: 'CONSUMER_KEY',
  consumer_secret: 'CONSUMER_SECRET',
  oauth_token: 'OAUTH_TOKEN',
  oauth_token_secret: 'OAUTH_TOKEN_SECRET',
}

client = Instapaper::Client.new(credentials)
client.folders
# => [#<Instapaper::Folder title="Design" display_title="Design" sync_to_mobile=true folder_id=1234567 position="1" type="folder" slug="design">]
