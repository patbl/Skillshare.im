require 'spec_helper'

describe Proposal do

  context "validations" do
    let(:proposal) { create(:proposal) }
    it "is valid with everything filled in" do
      expect(proposal).to be_valid
    end
  end
end
