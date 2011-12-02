require 'simplecov'
require File.expand_path('../../lib/instapaper', __FILE__)
require 'rspec'
require 'webmock/rspec'

def a_delete(path)
  a_request(:delete, Instapaper.endpoint_with_prefix + path)
end

def a_get(path)
  a_request(:get, Instapaper.endpoint_with_prefix + path)
end

def a_post(path)
  a_request(:post, Instapaper.endpoint_with_prefix + path)
end

def a_put(path)
  a_request(:put, Instapaper.endpoint_with_prefix + path)
end

def stub_delete(path)
  stub_request(:delete, Instapaper.endpoint_with_prefix + path)
end

def stub_get(path)
  stub_request(:get, Instapaper.endpoint_with_prefix + path)
end

def stub_post(path)
  stub_request(:post, Instapaper.endpoint_with_prefix + path)
end

def stub_put(path)
  stub_request(:put, Instapaper.endpoint_with_prefix + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
