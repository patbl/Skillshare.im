class UserMailer < ActionMailer::Base
  helper :application
  default from: "Skillshare.im <requests@skillshare.im>"

  def proposal_email(sender, body, proposal)
    @recipient = proposal.user
    @body = body
    subject = %[Request for "#{proposal.title}" on Skillshare.im]
    @greeting = <<EOF
Hi, #{@recipient.name},

#{sender.name} sent you the following message about your offer of #{proposal.title}. You can reply as you would to any e-mail.
EOF
    from = "#{@recipient.name} via Skillshare.im <#{sender.email}>"
    mail(to: @recipient.email, reply_to: sender.email, subject: subject, from: from)
  end
end
