source 'https://rubygems.org'
ruby "2.1.5"

gem 'rails', '~> 4.1.8'

gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.0'

# template and assets stacks
gem 'slim-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.3'
gem 'jquery-rails'
gem 'country_select', github: 'stefanpenner/country_select'

# Styling
gem 'semantic-ui-sass'

# functions
gem 'acts-as-taggable-on'

# S3 Amazon
gem 'fog'

#Image Uploaders
gem 'carrierwave'
gem 'mini_magick'

# third-party services
gem 'appsignal'

# authentication and authorization
gem 'sorcery'
gem 'pundit', github: 'elabs/pundit'

# server and database stacks
gem 'unicorn-rails'
gem 'pg'

# Background worker
gem 'sidekiq'

# Facebook API wrapper
gem 'fb_graph'

# Mailer
gem 'mailcatcher'

#Environment Variables
gem 'figaro'

group :production, :staging do
  gem 'heroku-deflater'
  gem 'rails_12factor'
end

group :developement do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec', require: false
  gem 'pry-rails'
  gem 'quiet_assets'
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'rb-readline', require: false
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner'
  gem 'webmock'
  gem 'nyan-cat-formatter'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'terminal-notifier-guard', '~> 1.6.1' #OSX 10.9+
end

gem 'sdoc', '~> 0.4.0', group: :doc