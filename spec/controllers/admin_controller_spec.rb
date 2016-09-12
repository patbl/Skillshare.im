require 'spec_helper'

describe AdminController do
  describe "#statistics" do
    it "assigns some statistics" do
      get :statistics
      expect(assigns(:user_count)).to eq 0
      expect(assigns(:offer_count)).to eq 0
      expect(assigns(:wanted_count)).to eq 0
      expect(assigns(:requisition_count)).to eq 0
      expect(assigns(:fulfillment_count)).to eq 0
    end
  end

  describe "#recent" do
    let!(:new_offer) { create(:offer, created_at: 29.days.ago) }
    let!(:old_offer) { create(:offer, created_at: 31.days.ago) }

    it "assigns recent offers" do
      get :recent, params: { days: "30" }

      expect(assigns(:offers)).to match_array [new_offer]
    end
  end
end
