source 'https://rubygems.org'

gem 'rake'
gem 'yard'

platforms :jruby do
  gem 'jruby-openssl', '~> 0.7'
end

group :test do
  gem 'json', :platforms => :ruby_18
  gem 'rspec', '~> 3.2'
  gem 'timecop'
  gem 'webmock', '>= 1.10.1'
end

gemspec
