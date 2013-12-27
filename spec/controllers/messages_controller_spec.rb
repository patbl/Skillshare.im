require 'spec_helper'

describe MessagesController do
  describe "POST :create" do
    context "user" do
      let(:sender) { create(:user, email: "abc@def.com") }
      let(:recipient) { build(:user, email: "jan@hotmail.com") }
      let(:offer) { build(:offer, user: recipient) }

      before { set_user_session(sender) }

      it "redirects the user to the offer page" do
        post :create, offer_id: offer, message: { body: "abc" }
        expect(response).to redirect_to(offer)
        expect(flash[:success]).to be
      end

      it "sends the e-mail message to the offerer" do
        post :create, offer_id: offer, message: { body: "abc" }
        expect(last_n_emails(2) { |email| email.to }).to include(offer.user.email)
      end

      it "sends a confirmation message to the requester" do
        post :create, offer_id: offer, message:  { body: "abc" }
        expect(last_n_emails(2) { |email| email.to }).to include(sender.email)
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
