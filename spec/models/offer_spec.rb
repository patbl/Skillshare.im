require 'spec_helper'

describe Offer do
  describe "#requisitions" do
    context "with no requisitions" do
      it "is empty" do
        offer = build(:offer)
        expect(offer.requisitions).to be_empty
      end
    end
  end

  describe "#record" do
    let(:offer) { build :offer }
    let(:requester) { build :user }

    it "creates a requisition" do
      expect(Requisition).to receive(:create).with(offer: offer, requester: requester, offerer: offer.user)
      offer.record(requester)
    end

    it "allows access to requisitions" do
      expect { offer.record(requester) }.to change(Requisition, :count).by(1)
      expect(offer.requisitions.count).to eq 1
    end
  end
end
