class Mailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  helper :application
end
