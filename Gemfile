source 'https://rubygems.org'
ruby "2.1.4"

gem 'rails', '~> 4.1.7'

gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.0'

# template and assets stacks
gem 'slim-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails', '~> 4.0.3'
gem 'jquery-rails'

# third-party services
gem 'appsignal'

# server and database stacks
gem 'unicorn-rails'
gem 'pg'

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
  gem 'dotenv-rails'
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