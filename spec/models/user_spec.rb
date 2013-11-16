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
end
