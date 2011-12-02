# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "instapaper/version"

Gem::Specification.new do |gem|
  gem.name        = "instapaper"
  gem.version     = Instapaper::VERSION

  gem.author      = "Steve Agalloco"
  gem.email       = "steve.agalloco@gmail.com"
  gem.homepage    = "https://github.com/spagalloco/instapaper"
  gem.summary     = %q{Ruby Instapaper Client}
  gem.description = %q{Ruby Instapaper Client}

  gem.add_development_dependency('rake', '~> 0.9')
  gem.add_development_dependency('rdiscount', '~> 1.6')
  gem.add_development_dependency('rspec', '~> 2.7')
  gem.add_development_dependency('simplecov', '~> 0.5')
  gem.add_development_dependency('yard', '~> 0.7')
  gem.add_development_dependency('json', '>= 0')
  gem.add_development_dependency('webmock', '~> 1.7')

  gem.add_runtime_dependency('hashie', '~> 1.1.0')
  gem.add_runtime_dependency('faraday_middleware', '~> 0.7')
  gem.add_runtime_dependency('multi_json', '~> 1.0.3')
  gem.add_runtime_dependency('rash', '~> 0.3')
  gem.add_runtime_dependency('simple_oauth', '~> 0.1')

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]
end
