require 'spec_helper'

describe Proposal do
  let(:proposal) { create(:proposal) }

  context "validations" do
    it "is valid with everything filled in" do
      expect(proposal).to be_valid
    end
  end

  context "#request?" do
    it "returns the opposite of what #offer? returns" do
      proposal.offer = true
      expect(proposal.request?).to eq(false)
      proposal.offer = false
      expect(proposal.request?).to eq(true)
    end
  end

  context "scopes" do
    context "#requests" do
      it "returns nil if there aren't any" do
        offer = create :proposal, offer: true
        expect(Proposal.requests).to be_empty
      end
      it "returns requests if there are some" do
        requests = create_list :proposal, 3, offer: false
        expect(Proposal.requests).to match_array requests
      end
    end

    context "#offers" do
      it "returns nil if there aren't any" do
        offer = create :proposal, offer: false
        expect(Proposal.offers).to_not include(offer)
      end
      it "returns offers if there are some" do
        offers = create_list :proposal, 3, offer: true
        expect(offers).to match_array offers
      end
    end
  end
end
