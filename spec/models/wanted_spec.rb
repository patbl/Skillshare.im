require 'spec_helper'

describe Wanted do
  let(:wanted) { build :wanted }
  let(:fulfiller) { build :user }

  describe "#record" do
    it "creates a requisition" do
      expect(Fulfillment).to receive(:create)
        .with(wanted: wanted, fulfiller: fulfiller, wanter: wanted.user)
      wanted.record(fulfiller)
    end

    it "allows access to requisitions" do
      expect { wanted.record(fulfiller) }.to change(Fulfillment, :count).by(1)
      expect(wanted.fulfillments.count).to eq 1
    end
  end
end
