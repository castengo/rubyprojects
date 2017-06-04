source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1', '>= 5.1.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0', '>= 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.6', '>= 2.6.4'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# boostrap styling for app
gem 'bootstrap-sass', '~> 3.3.6'
# postgres database
gem 'pg', '~> 0.20.0'
# manage users
gem 'devise', '~> 4.3'
# paginating
gem 'will_paginate', '~> 3.1.0'
# get instagram posts
gem 'httparty', '0.15.5'
# extract profile picture
gem 'nokogiri'
# Use Unicorn as the app server
# gem 'unicorn'
gem 'listen'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'web-console', '~> 2.0'
  gem 'pry-rails'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'spring'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  # gem 'guard-minitest',     '2.3.1'
end

group :production do
	gem 'rails_12factor', '0.0.2'
	gem 'puma', '3.1.0'
end

ruby "2.4.1"
