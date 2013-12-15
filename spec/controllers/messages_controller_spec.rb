require 'spec_helper'

describe MessagesController do
  describe "POST :create" do
    context "user" do
      before do
        @sender = create :user
        @proposal =  create :proposal
        set_user_session(@sender)
      end

      it "saves the message if things are Kosher" do
        post :create, proposal_id: @proposal, message: { body: "abc" }
        expect(response).to redirect_to(@proposal)
      end

      it "sends the e-mail message if the record is valid" do
        post :create, proposal_id: @proposal, message: { body: "abc" }
        expect(last_email.to).to include(@proposal.user.email)
      end

      it "sets the previous page in the session hash" do
        expect(request).to receive(:referer).and_return("previous page")
        post :create, proposal_id: @proposal, message: { body: "abc" }
        expect(response).to redirect_to "previous page"
      end
    end

    context "guest" do
      it "requires the user to be signed in" do
        post :create, proposal_id: "123"
        expect(response).to redirect_to signin_path
      end

      it "saves the original page in the session hash" do
        expect(request).to receive(:referer).and_return("previous page")
        post :create, proposal_id: "123"
        expect(session[:return_to].first.first).to eq "previous page"
      end
    end
  end
end
