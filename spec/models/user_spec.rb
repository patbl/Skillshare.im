require 'spec_helper'

describe User do
  let(:user_with_proposals) { build(:user_with_proposals) }

  context "validations" do
    it "is valid with a provider and a UID" do
      expect(build(:user)).to be_valid
    end
    it "is invalid without a provider" do
      expect(build(:user, provider: nil)).to have(1).error_on(:provider)
    end
    it "is invalid without a UID" do
      expect(build(:user, uid: nil)).to have(1).error_on(:uid)
    end
    it "is invalid with a duplicate UID" do
      old_user = create :user
      new_user = build(:user, uid: old_user.uid)
      expect(new_user).to have(1).error_on(:uid)
    end
  end
end
