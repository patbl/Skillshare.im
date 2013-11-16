require 'spec_helper'

describe Proposal do
  let(:proposal) { build(:proposal) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:category_list) }

  it { should belong_to(:user) }
  it { should ensure_inclusion_of(:category_list)
      .in_array(ApplicationHelper::CATEGORIES.map { |e| Array(e) }) }

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
      before { create :offer }

      it "returns nil if there aren't any" do
        expect(Proposal.requests).to be_empty
      end

      it "returns requests if there are some" do
        request = create :request
        expect(Proposal.requests).to match_array Array(request)
      end
    end

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
