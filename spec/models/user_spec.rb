require 'spec_helper'

describe User do
  it_behaves_like "Mappable"

  it "deletes the user's offers when the user's account is deleted" do
    user = create :user
    create :offer, user: user
    expect { user.destroy! }.to change(Offer, :count).by(-1)
  end

  context "after creating a user" do
    let(:user) { create(:user) }

    it "creates a subscription" do
      subscription = user.subscriptions.first
      expect(subscription.frequency).to eq "biweekly"
    end
  end
end
