require 'spec_helper'

describe MessagesController do
  describe "POST :create" do
    context "user" do
      let(:sender) { create(:user, email: "abc@def.com") }
      let(:recipient) { build(:user, email: "jan@hotmail.com") }
      let(:offer) { create(:offer, user: recipient) }

      before do
        set_user_session(sender)
        post :create, params: { offer_id: offer, message: { body: "abc" }, type: "Offer" }
      end

      it "redirects the user to the offer page" do
        expect(response).to redirect_to(offer)
        expect(flash[:success]).to be
      end

      it "sends the e-mail message to the offerer" do
        expect(ActionMailer::Base.deliveries.flat_map(&:to)).to include(offer.user.email)
      end

      it "sends a confirmation message to the requester" do
        expect(ActionMailer::Base.deliveries.flat_map(&:to)).to include(sender.email)
      end

      it "records requisitions" do
        expect {
          post :create, params: { offer_id: offer, message: { body: "abc" }, type: "Offer" }
        }.to change(Requisition, :count).by(1)
      end
    end

    context "guest" do
      it "requires the user to be signed in" do
        post :create, params: { wanted_id: "123", type: "Wanted" }
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
