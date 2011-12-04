# Instapaper

Instapaper is a ruby wrapper for interacting with [Instapaper's Full Developer API](http://www.instapaper.com/api/full).  Note that access to the Full API is restricted to Instapaper subscribers only.

## Installation

    gem install instapaper

## Usage

Instapaper offers full support for all methods exposed through the Full API.  Note that Instapaer does not support the request-token/authorize workflow.  To obtain an access token, use the `access_token` method.

## Configuration

```ruby
Instapaper.configure do |config|
  config.consumer_key = YOUR_CONSUMER_KEY
  config.consumer_secret = YOUR_CONSUMER_SECRET
  config.oauth_token = YOUR_OAUTH_TOKEN
  config.oauth_token_secret = YOUR_OAUTH_TOKEN_SECRET
end
```

## Authentication

To obtain an access token via xAuth:

```ruby
Instapaper.access_token(username, password)
```

You can also verify credentials once you have received tokens:

```ruby
Instapaper.verify_credentials
```

## Bookmark Operations

Retrieve a list of bookmarks:

```ruby
Instapaper.bookmarks
```

Add a new bookmark:

```ruby
Instapaper.add_bookmark('http://someurl.com', :title => 'This is the title', :description => 'This is the description')
```

Remove a bookmark:

```ruby
Instapaper.delete_bookmark(bookmark_id)
```

Update read progress:

```ruby
Instapaper.update_read_progress(bookmark_id, 0.5)
```

Star/Un-star a bookmark:

```ruby
Instapaper.star(bookmark_id)
Instapaper.unstar(bookmark_id)
```

Archive/Un-archive a bookmark:

```ruby
Instapaper.archive(bookmark_id)
Instapaper.unarchive(bookmark_id)
```

Move a bookmark to a folder:

```ruby
Instapaper.move(bookmark_id, folder_id)
```

Obtain the text of a bookmark:

```ruby
Instapaper.text(bookmark_id)
```

## Folder Operations


To obtain the list of folders:

```ruby
Instapaper.folders
```

You can add by passing a name:

```ruby
Instapaper.add_folder('eventmachine')
```

And remove folders by referencing a folder by it's id.

```ruby
Instapaper.delete_folder(folder_id)
```

Lastly, the folders can be reordered:

```ruby
Instapaper.set_order(['folder_id1:2','folder_id2:1'])
```

## Restrictions

Users without an Instapaper Subscription may only invoke the following calls:

```ruby
Instapaper.access_token
Instapaper.verify_credentials
Instapaper.add_bookmark
Instapaper.folders
```

## <a name="build"></a>Build Status
[![Build Status](https://secure.travis-ci.org/spagalloco/instapaper.png?branch=master)][travis]

[travis]: http://travis-ci.org/spagalloco/instapaper

## <a name="dependencies"></a>Dependency Status
[![Dependency Status](https://gemnasium.com/spagalloco/instapaper.png?travis)][gemnasium]

[gemnasium]: https://gemnasium.com/spagalloco/instapaper


## Documentation

[http://rdoc.info/gems/instapaper](http://rdoc.info/gems/instapaper)

## Contributing

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Steve Agalloco. See [LICENSE](https://github.com/spagalloco/instapaper/blob/master/LICENSE.md) for details.
