require 'spec_helper'

describe MessagesController do
  describe "POST :create" do
    context "user" do
      before do
        @sender = create :user
        @offer =  create :offer
        set_user_session(@sender)
      end

      it "saves the message" do
        post :create, offer_id: @offer, message: { body: "abc" }
        expect(response).to redirect_to(@offer)
        expect(flash[:success]).to be
      end

      it "sends the e-mail message if the record is valid" do
        post :create, offer_id: @offer, message: { body: "abc" }
        expect(last_email.to).to include(@offer.user.email)
      end
    end

    context "guest" do
      it "requires the user to be signed in" do
        post :create, offer_id: "123"
        expect(response).to redirect_to signin_path
      end
    end
  end
end
