require 'spec_helper'

describe Offer do
  let(:offer) { build(:offer) }

  it { should belong_to(:user) }
  it { should ensure_inclusion_of(:category_list)
      .in_array(ApplicationHelper::CATEGORIES.map { |e| Array(e) }) }

  context "validations" do
    it "is valid with everything filled in" do
      expect(offer).to be_valid
    end
  end
end
