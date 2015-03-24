source 'http://rubygems.org'
ruby "2.2.1"

gem 'rails', '~> 4.2'

gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.0'

# template and assets stacks
gem 'slim-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.3'
gem 'jquery-rails'
gem 'country_select'
gem 'iso_country_codes'
gem 'best_in_place', '~> 3.0.1'
gem 'remotipart', '~> 1.2'
gem 'pjax_rails'

# database tagging
gem 'acts-as-taggable-on'

# Semantic UI
gem 'semantic-ui-sass'

# pagination
gem 'will_paginate'

# S3 Amazon
gem 'fog'

# Responders
gem 'responders'

# image Uploaders
gem 'carrierwave'
gem 'mini_magick'

# third-party services
gem 'appsignal'

# geolocation
gem 'geoip'

# authentication and authorization
gem 'sorcery'
gem 'pundit'

# server and database stacks
gem 'unicorn-rails'
gem 'pg'

# background worker
gem 'sidekiq'

# social media API wrappers
gem 'fb_graph'
gem 'twitter'

# environment variables
gem 'figaro'

group :production, :staging do
  gem 'heroku-deflater'
  gem 'rails_12factor'
end

group :developement do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec', require: false
  gem 'quiet_assets'
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'rb-readline', require: false
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'heroku_san'
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner'
  gem 'webmock'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'terminal-notifier-guard', '~> 1.6.1' #OSX 10.9+
end

gem 'sdoc', '~> 0.4.0', group: :doc