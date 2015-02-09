lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'instapaper/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday_middleware', '~> 0.7'
  spec.add_dependency 'multi_json', '~> 1'
  spec.add_dependency 'rash'
  spec.add_dependency 'simple_oauth'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.author        = 'Steve Agalloco'
  spec.description   = "Ruby Client for Instapaper's Full API"
  spec.email         = 'steve.agalloco@gmail.com'
  spec.files         = `git ls-files`.split("\n")
  spec.homepage      = 'https://github.com/stve/instapaper'
  spec.licenses      = %w(MIT)
  spec.name          = 'instapaper'
  spec.require_paths = %w(lib)
  spec.required_ruby_version = '>= 2.0.0'
  spec.summary       = 'Ruby Instapaper Client'
  spec.version       = Instapaper::VERSION
end
