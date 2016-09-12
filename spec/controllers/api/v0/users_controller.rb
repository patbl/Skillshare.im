require 'spec_helper'

RSpec.describe Api::V0::UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:offer) { create(:offer, user: user) }

  describe "GET #show" do
    it "returns something sensible" do
      get :show, params: { id: "1" }

      body = JSON.parse(response.body)
      attributes = body["data"]["attributes"]
      included = body["included"]

      expect(attributes["email"]).to eq user.email
      expect(included.first["attributes"]["title"]).to eq offer.title
    end
  end
end
