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

  context "#new?" do
    it "returns true if user was created recently" do
      expect(build_stubbed(:user).new?).to be_true
    end

    it "returns false when user wasn't created recently" do
      user = build_stubbed(:user, created_at: 1.year.ago)
      expect(user.new?).to be_false
    end
  end
end
