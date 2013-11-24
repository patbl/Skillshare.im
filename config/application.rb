require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Skillshare
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.initialize_on_precompile = false
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

    config.action_mailer.smtp_settings = {
      address: "smtp.mandrillapp.com",
      port: 25, # ports 587 and 2525 are also supported with STARTTLS
      enable_starttls_auto: true, # detects and uses STARTTLS
      user_name: ENV["MANDRILL_USER_NAME"],
      password: ENV["MANDRILL_PASSWORD"], # SMTP password is any valid API key
      authentication: "login", # Mandrill supports 'plain' or 'login'
      domain: "ea-skillshare.herokuapp.com", # your domain to identify your server when connecting
    }
  end
end
