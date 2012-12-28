# -*- encoding: utf-8 -*-
require File.expand_path('../lib/instapaper/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "instapaper"
  gem.version     = Instapaper::VERSION

  gem.author      = "Steve Agalloco"
  gem.email       = "steve.agalloco@gmail.com"
  gem.homepage    = "https://github.com/spagalloco/instapaper"
  gem.summary     = %q{Ruby Instapaper Client}
  gem.description = %q{Ruby Instapaper Client}

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'kramdown'
  gem.add_development_dependency 'rspec', '~> 2'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'webmock'

  gem.add_runtime_dependency('faraday_middleware', '~> 0.7')
  gem.add_runtime_dependency('multi_json', '~> 1')
  gem.add_runtime_dependency('rash', '~> 0.3')
  gem.add_runtime_dependency('simple_oauth', '~> 0.1')

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
end
