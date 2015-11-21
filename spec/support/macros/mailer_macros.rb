module MailerMacros
  def reset_email
    ActionMailer::Base.deliveries.clear
  end
end
