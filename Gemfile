source 'http://rubygems.org'

ruby '2.1.0'
gem 'rails', '4.0.2'

group :test, :development do
  gem 'rspec-rails', '~> 3.0.0.beta1'
  gem 'factory_girl_rails'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
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
  gem 'poltergeist'
  gem 'launchy'
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
end

gem 'pg'
gem 'unicorn'
gem 'therubyracer', platforms: :ruby
gem 'haml-rails'
gem 'sass-rails'
gem 'anjlab-bootstrap-rails', '~> 3.0.3.0', require: 'bootstrap-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'omniauth-facebook'
gem 'omniauth-browserid'
gem 'figaro'
gem 'redcarpet'
gem 'simple_form'
gem 'coveralls', require: false
gem 'acts-as-taggable-on'
gem 'font-awesome-rails'
gem 'geocoder'
gem 'roadie', '~> 2.4.2'
gem 'newrelic_rpm'
gem 'draper'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
