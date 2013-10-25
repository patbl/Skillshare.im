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
end
