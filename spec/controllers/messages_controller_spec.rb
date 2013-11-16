require 'spec_helper'

describe MessagesController do
  describe "GET :new" do
    it "requires the user to be signed in" do
      get :new, proposal_id: 1
      expect(response).to redirect_to signin_path
    end

    it "renders the contact form when a user is signed in" do
      sender = create :user
      set_user_session(sender)
      expect(Proposal).to receive(:find)
      get :new, proposal_id: "123"
      expect(response).to render_template :new
    end
  end

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

    it "dosn't send the e-mail message if the record isn't valid" do
      set_user_session(sender)
      post :create, proposal_id: proposal, message: { body: "" }
      expect(response).to render_template(:new)
    end
  end
end
