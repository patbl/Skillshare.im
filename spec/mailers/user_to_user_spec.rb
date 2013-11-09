require "spec_helper"

describe UserToUser do
  describe "contact" do
    it "renders the headers" do
      sender = create :user
      recipient = create :user
      message = create :message, sender_id: sender.id, recipient_id: recipient.id
      mail = UserToUser.contact(message)
      mail.subject.should eq("Message from #{recipient.name}")
      mail.to.should eq([recipient.email])
      mail.from.should eq(["don't_even_think_of_replying@ea-skillshare.herokuapp.com"])
    end

    it "renders the body" do
      mail = UserToUser.contact(create :message_with_users)
      mail.body.encoded.should match("Hi")
    end
  end

end
