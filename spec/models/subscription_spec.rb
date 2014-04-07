require 'spec_helper'

describe Subscription do
  describe "validations" do
    let(:subscription) { build(:subscription) }

    context "invalid subscription" do
      it "requires a user" do
        subscription.user = nil
        expect(subscription).not_to be_valid
      end
    end

    context "valid subscription" do
      it "requires a user" do
        expect(subscription).to be_valid
      end
    end
  end
end
