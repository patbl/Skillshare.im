source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.0'

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'debugger'
  gem 'factory_girl_rails'
  gem 'jazz_hands'
  gem 'libnotify'
end

group :development do
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-spring'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'guard-bundler'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'

  # fixes "can't modify string; temporarily locked" error
  # (http://stackoverflow.com/questions/19496932)
  gem 'rb-readline', require: false
end

group :test do
  gem 'simplecov', require: false
  gem 'ffaker'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'capybara-webkit'
  gem 'launchy'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'therubyracer', platforms: :ruby
gem 'haml-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'omniauth-facebook'
gem 'figaro'
gem 'redcarpet'
