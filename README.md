# Instapaper

[![Gem Version](http://img.shields.io/gem/v/instapaper.svg)][gem]
![Tests](https://github.com/stve/instapaper/actions/workflows/ci.yml/badge.svg)

[gem]: https://rubygems.org/gems/instapaper

Instapaper is a ruby wrapper for interacting with [Instapaper's Full API](https://www.instapaper.com/api/full).  Note that access to the Full API is restricted to Instapaper subscribers only.

## Installation

    gem install instapaper

## Usage

This library offers full support for all methods exposed through Instapaper's Full API.  Note that Instapaper's API does not support the request-token/authorize workflow. To obtain an access token, use the `access_token` method.

## Changes in 1.0.0

If you've used earlier versions of this library, a lot has changed in version `1.x`. While not a total rewrite, I've changed a number of things based on my experience writing API libraries:

* swapped out Faraday for http.rb
* responses now return custom classes instead of Hashie::Rash objects
* most API methods are more clear as to their behavior (i.e., `#star_bookmark` instead of just `#star`)
* module-based configuration and invocation has been removed, you'll now need to instantiate an `Instapaper::Client` instead (see usage below)
* Improved error handling
* Updates for version 1.1 of Instapaper's API
* Support for Highlights API

## Configuration

```ruby
client = Instapaper::Client.new do |client|
  client.consumer_key = YOUR_CONSUMER_KEY
  client.consumer_secret = YOUR_CONSUMER_SECRET
  client.oauth_token = YOUR_OAUTH_TOKEN
  client.oauth_token_secret = YOUR_OAUTH_TOKEN_SECRET
end
```

## Authentication

To obtain an access token via xAuth:

```ruby
client.access_token(username, password)
```

You can also verify credentials once you have received tokens:

```ruby
client.verify_credentials
```

## Bookmark Operations

Retrieve a list of bookmarks:

```ruby
client.bookmarks
```

Add a new bookmark:

```ruby
bookmark = {
  title: 'This is the title',
  description: 'This is the description',
}

client.add_bookmark('http://someurl.com', bookmark)
```

Remove a bookmark:

```ruby
client.delete_bookmark(bookmark_id)
```

Update read progress:

```ruby
client.update_read_progress(bookmark_id, 0.5)
```

Star/Un-star a bookmark:

```ruby
client.star_bookmark(bookmark_id)
client.unstar_bookmark(bookmark_id)
```

Archive/Un-archive a bookmark:

```ruby
client.archive_bookmark(bookmark_id)
client.unarchive_bookmark(bookmark_id)
```

Move a bookmark to a folder:

```ruby
client.move_bookmark(bookmark_id, folder_id)
```

Obtain the text of a bookmark:

```ruby
client.get_text(bookmark_id)
```

## Folder Operations


To obtain the list of folders:

```ruby
client.folders
```

You can add by passing a name:

```ruby
client.add_folder('eventmachine')
```

And remove folders by referencing a folder by it's id.

```ruby
client.delete_folder(folder_id)
```

Lastly, the folders can be reordered:

```ruby
client.set_order(['folder_id1:2','folder_id2:1'])
```

## Highlights Operations

Obtain highlights for a bookmark:

```ruby
client.highlights(bookmark_id)
```

Add a highlight for a bookmark:

```ruby
highlight = {
  text: 'And so we beat on, boats against the current, borne back ceaselessly into the past.',
  position: 20,
}

client.add_highlight(bookmark_id, highlight)
```

Remove a highlight:

```ruby
client.delete_highlight(highlight_id)
```

## Documentation

[http://rdoc.info/gems/instapaper](http://rdoc.info/gems/instapaper)

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile, gem version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2015 Steve Agalloco. See [LICENSE](https://github.com/stve/instapaper/blob/master/LICENSE.md) for details.
