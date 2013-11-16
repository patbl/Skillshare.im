source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.1'

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
  # gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
end

group :development do
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-spring'
  gem 'spring-commands-rspec'
  gem 'guard-bundler'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'letter_opener'
end

group :test do
  gem 'simplecov', require: false
  gem 'ffaker'
  gem 'capybara'
  #gem 'capybara-webkit'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'therubyracer', platforms: :ruby
gem 'haml-rails'
gem 'sass-rails'
gem 'anjlab-bootstrap-rails', '~> 3.0.2.0', require: 'bootstrap-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'omniauth-facebook'
gem 'figaro'
gem 'redcarpet'
gem 'simple_form'
gem 'coveralls', require: false
gem 'acts-as-taggable-on'
gem 'mailboxer'
gem 'font-awesome-rails'
