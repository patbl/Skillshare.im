require 'spec_helper'

describe Offer do
  let(:offer) { build(:offer) }

  it_behaves_like "Mappable"

  context "validations" do
    it "is valid with everything filled in" do
      expect(offer).to be_valid
    end
  end
end
