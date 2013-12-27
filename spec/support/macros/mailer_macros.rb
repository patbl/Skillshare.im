module MailerMacros
  def last_n_emails(n, field = nil)
    emails = ActionMailer::Base.deliveries.last(n)
    if block_given?
      emails.map { |email| yield email }.flatten
    else
      emails
    end
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end
end
