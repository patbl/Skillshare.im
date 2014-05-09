require 'spec_helper'

describe StatisticsController do
  describe "#index" do
    it "assigns some statistics" do
      get :index
      expect(assigns(:user_count)).to eq 0
      expect(assigns(:offer_count)).to eq 0
      expect(assigns(:wanted_count)).to eq 0
      expect(assigns(:requisition_count)).to eq 0
      expect(assigns(:fulfillment_count)).to eq 0
    end
  end
end
