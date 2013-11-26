require 'spec_helper'

describe MessagesController do
  describe "POST :create" do
    let(:sender) { create :user }
    let(:proposal) { create(:proposal) }

    it "requires the user to be signed in" do
      post :create, proposal_id: "123"
      expect(response).to redirect_to signin_path
    end

    it "saves the message if things are Kosher" do
      set_user_session(sender)
      post :create, proposal_id: proposal, message: { body: "abc" }
      expect(response).to redirect_to(proposal)
    end

    it "sends the e-mail message if the record is valid" do
      set_user_session(sender)
      post :create, proposal_id: proposal, message: { body: "abc" }
      expect(last_email.to).to include(proposal.user.email)
    end
  end
end
