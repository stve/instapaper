require 'instapaper'

credentials = {
  consumer_key: 'CONSUMER_KEY',
  consumer_secret: 'CONSUMER_SECRET',
}

client = Instapaper::Client.new(credentials)
client.access_token('username', 'password')
# => #<Instapaper::Credentials oauth_token="710c838347ae178b4a92c6912e7e72e16c7e42f2" oauth_token_secret="XSXuU7TxBCzbKLjHH4R5iv8wfESLjeY9DI9sAdRBmCnui1E64m">
