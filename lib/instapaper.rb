require 'instapaper/configuration'
require 'instapaper/client'

module Instapaper
  extend Configuration

  # Alias for Instapaper::Client.new
  #
  # @return [Instapaper::Client]
  def self.client(options={})
    Instapaper::Client.new(options)
  end

  # Delegate to Instapaper::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    client.respond_to?(method, include_private) || super(method, include_private)
  end

  # Custom error class for rescuing from all Instapaper errors
  class Error < StandardError; end
end
