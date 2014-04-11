class NewProposalsMailerPreview < ActionMailer::Preview
  def updates_email
    @user = FactoryGirl.create :user
    @offers = FactoryGirl.create_list :offer, 3
    @wanteds = FactoryGirl.create_list :wanted, 1
    NewProposalsMailer.updates_email(@user, @offers, @wanteds)
  end
end
