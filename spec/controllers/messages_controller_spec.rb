require 'spec_helper'

describe MessagesController do
  describe "POST :create" do
    context "user" do
      before do
        @sender = create :user
        @proposal =  create :proposal
        set_user_session(@sender)
      end

      it "saves the message" do
        post :create, proposal_id: @proposal, message: { body: "abc" }
        expect(response).to redirect_to(@proposal)
        expect(flash[:success]).to be
      end

      it "sends the e-mail message if the record is valid" do
        post :create, proposal_id: @proposal, message: { body: "abc" }
        expect(last_email.to).to include(@proposal.user.email)
      end
    end

    context "guest" do
      it "requires the user to be signed in" do
        post :create, proposal_id: "123"
        expect(response).to redirect_to signin_path
      end
    end
  end
end
