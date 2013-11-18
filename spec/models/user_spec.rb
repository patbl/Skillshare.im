require 'spec_helper'

describe User do
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:uid) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:location) }

  it { should have_many(:proposals).dependent(:destroy) }

  context "validations" do
    it "my user factory might not be broken" do
      expect(build(:user)).to be_valid
    end
  end

  context "#to_marker" do
    it "returns a correctly formatted hash" do
      offer = build_stubbed :user, name: "Sue", latitude: 1, longitude: 2
      expected = { latlng: [1.0, 2.0], popup: "Sue" }
      expect(offer.to_marker).to eq(expected)
    end
  end
end
