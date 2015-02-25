require 'spec_helper'
require Rails.root.join("spec/models/concerns/mappable_spec.rb")

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
      expect(subscription.last_sent).to eq  Date.today
    end
  end

  it "doesn't allow a blank name on update" do
    user = create :user, first_name: ""
    expect {
      user.update!(about: "I'm too lazy to type my name")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe "#to_url" do
    it "returns the URL for the user" do
      user = build :user
      allow(user).to receive(:id).and_return(789)
      expect(user.to_url).to eq "http://skillshare.im/community/789"
    end
  end

end
