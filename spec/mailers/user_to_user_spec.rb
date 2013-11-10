require "spec_helper"

describe UserToUser do
  describe "contact" do
    it "renders the headers" do
      sender = create :user
      proposal = create :proposal
      message = create :message, sender_id: sender.id, proposal_id: proposal.id
      mail = UserToUser.contact(message)
      expect(mail.subject).to eq "Message from #{sender.name} about #{proposal.title}"
      expect(mail.to).to eq [proposal.user.email]
      expect(mail.from).to eq ["don't_even_think_of_replying@ea-skillshare.herokuapp.com"]
    end

    it "renders the body" do
      mail = UserToUser.contact(create :message_with_users)
      mail.body.encoded.should match("Hi")
    end
  end
end
