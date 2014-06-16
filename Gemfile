source 'http://rubygems.org'

ruby '2.1.2'
gem 'rails', '4.1.1'

group :test, :development do
  gem 'rspec', '~> 3.0.0.beta2'
  gem 'rspec-rails', '~> 3.0.0.beta2'
  gem 'factory_girl_rails'
  gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger'
  gem 'pry-byebug'
end

group :development do
  gem 'guard-rails'
  gem 'guard-rspec', '~> 4.2.8'
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
  gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
  gem 'growl' if /darwin/ =~ RUBY_PLATFORM
end

group :test do
  gem 'simplecov', require: false
  gem 'ffaker'
  gem 'capybara', github: 'jnicklas/capybara', branch: 'master'
  gem 'poltergeist'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'rake'
end

group :production do
  gem 'rails_12factor'
end

gem 'unicorn'
gem 'therubyracer', platforms: :ruby
gem 'haml-rails'
gem 'sass-rails'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'omniauth-facebook'
gem 'omniauth-browserid'
gem 'figaro'
gem 'redcarpet'
gem 'simple_form'
gem 'coveralls', require: false
gem 'acts-as-taggable-on'
gem 'font-awesome-rails'
gem 'geocoder'
gem 'roadie', '~> 2.4.3'
gem 'newrelic_rpm'
gem 'draper'
gem 'kaminari'
gem 'bootstrap-kaminari-views'
gem 'sprockets', '=2.11.0'
gem 'gibbon'

gem 'pg'
