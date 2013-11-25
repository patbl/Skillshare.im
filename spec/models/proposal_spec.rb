require 'spec_helper'

describe Proposal do
  let(:proposal) { build(:proposal) }

  it { should belong_to(:user) }
  it { should ensure_inclusion_of(:category_list)
      .in_array(ApplicationHelper::CATEGORIES.map { |e| Array(e) }) }

  context "validations" do
    it "is valid with everything filled in" do
      expect(proposal).to be_valid
    end
  end

  context "#latlng" do
    let(:proposal) { build_stubbed(:proposal, latitude: 1, longitude: 2) }
    it "returns an array with the latitude and longitude" do
      expect(proposal.latlng).to eq [1, 2]
    end
  end

  context "scopes" do
    context "#offers" do
      before { create :request }

      it "returns nil if there aren't any" do
        expect(Proposal.offers).to be_empty
      end

      it "returns offers if there are some" do
        offer = create :offer
        expect(Proposal.offers).to match_array Array(offer)
      end
    end
  end
end
