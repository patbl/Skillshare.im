ActionMailer::Base.smtp_settings = {
  address: "smtp.mandrillapp.com",
  port: 25, # ports 587 and 2525 are also supported with STARTTLS
  enable_starttls_auto: true, # detects and uses STARTTLS
  user_name: ENV["MANDRILL_USER_NAME"],
  password: ENV["MANDRILL_PASSWORD"], # SMTP password is any valid API key
  authentication: "login", # Mandrill supports 'plain' or 'login'
  domain: "skillshare.im", # your domain to identify your server when connecting
}


ActionMailer::Base.default_url_options = { host: "localhost:3000" }

require 'development_mail_interceptor' #add this line
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.staging? || Rails.env.development?
