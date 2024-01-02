# frozen_string_literal: true

source 'https://rubygems.org'

gem 'http_parser.rb', '~> 0.6.0', platforms: [:jruby]
gem 'jekyll', '~> 4.3'
gem 'wdm', '~> 0.1.1', platforms: %i[mingw x64_mingw mswin]

group :jekyll_plugins do
  gem 'jekyll-feed', '~> 0.17'
end

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem 'tzinfo', '>= 1', '< 3'
  gem 'tzinfo-data'
end

group :development, :test do
  gem 'code-scanning-rubocop', '~> 0.6'
  gem 'rake', '~> 13.1'
  gem 'rubocop', '>= 1.45.0', '< 2'
  gem 'rubocop-performance', '~> 1.19'
  gem 'rubocop-jekyll', '~> 0.13'
  gem 'rubocop-rake', '~> 0.6'
  gem 'rubocop-rspec', '~> 2.25'
  gem 'rubocop-yard', '~> 0.9'
end

group :doc do
  gem 'github-markup', '~> 4.0'
  gem 'redcarpet', '~> 3.6'
  gem 'yard', '~> 0.9'
end
