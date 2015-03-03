unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
  end
end

require 'instapaper'
require 'rspec'
require 'webmock/rspec'

def a_post(path)
  a_request(:post, Instapaper::HTTP::Request::BASE_URL + path)
end

def stub_post(path)
  stub_request(:post, Instapaper::HTTP::Request::BASE_URL + path)
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
