require 'instapaper'

credentials = {
  consumer_key: 'CONSUMER_KEY',
  consumer_secret: 'CONSUMER_SECRET',
  oauth_token: 'OAUTH_TOKEN',
  oauth_token_secret: 'OAUTH_TOKEN_SECRET',
}

client = Instapaper::Client.new(credentials)
client.verify_credentials
# => #<Instapaper::User username="username" user_id=123456 type="user" subscription_is_active=false>
