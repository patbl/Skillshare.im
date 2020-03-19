ActionMailer::Base.smtp_settings = {
  address: "smtp.sendgrid.net",
  port: 25, # ports 587 and 2525 are also supported with STARTTLS
  enable_starttls_auto: true, # detects and uses STARTTLS
  user_name: Rails.application.credentials.email_service_user_name,
  password: Rails.application.credentials.email_service_password, # SMTP password is any valid API key
  authentication: "login",
  domain: "skillshare.im", # your domain to identify your server when connecting
}

require 'development_mail_interceptor'
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.staging? || Rails.env.development?
