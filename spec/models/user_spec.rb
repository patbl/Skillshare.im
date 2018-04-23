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
      expect(subscription.last_sent).to eq  Date.today
    end
  end

  it "doesn't allow a blank name on update" do
    user = create :user, first_name: ""
    expect {
      user.update!(about: "I'm too lazy to type my name")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end

  describe ".find_or_create_from_auth!" do
    context "when the auth hash is missing the info attribute" do
      it "logs the auth hash" do
        auth = OmniAuth.config.mock_auth[:facebook].dup.tap do |auth|
          auth.delete(:info)
        end
        logger = instance_double(ActiveSupport::Logger).tap do |logger|
          expect(logger).to receive(:info).with(/missing/)
        end
        allow(Rails).to receive(:logger).and_return(logger)

        described_class.find_or_create_from_auth!(auth)
      end
    end
  end

  describe "#to_url" do
    it "returns the URL for the user" do
      user = build :user
      allow(user).to receive(:id).and_return(789)
      expect(user.to_url).to eq "https://skillshare.im/community/789"
    end
  end
end
