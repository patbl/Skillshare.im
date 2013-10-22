source 'https://rubygems.org'

gem 'rails', '4.0.0'

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'debugger'
  gem 'factory_girl_rails'
  gem 'libnotify'
end

group :development do
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-spring'
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-rails'
  gem 'meta_request'
  gem 'rb-readline' # fixes "can't modify string; temporarily locked" error (http://stackoverflow.com/questions/19496932)
end

group :test do
  gem 'simplecov', require: false
  gem 'capybara'
  gem 'launchy'
end

group :production do
  gem 'pg'
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
