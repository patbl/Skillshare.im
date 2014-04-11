class NewProposalsMailer < ActionMailer::Base
  helper :application
  default from: "updates@skillshare.im"

  def updates_email(user, offers, wanteds)
    @user = user
    @offers = offers
    @wanteds = wanteds
    mail(to: @user.email, subject: "New offers and wanteds on Skillshare.im")
  end
end
