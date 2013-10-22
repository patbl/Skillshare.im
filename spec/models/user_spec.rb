require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  let(:user_with_proposals) { create(:user_with_proposals) }

  context "validations" do
    it "is valid with a provider and a UID" do
      expect(user).to be_valid
    end
    it "is invalid without a provider" do
      user.provider = nil
      expect(user).to be_invalid
    end
    it "is invalid without a UID" do
      user.uid = nil
      expect(user).to be_invalid
    end
    it "is invalid with a duplicate UID" do
      user.update_attributes uid: '123'
      new_user = build(:user, uid: '123')
      expect(new_user).to be_invalid
    end
  end

  describe "#full_name" do
    let(:user) { create(:user) }
    it "returns the user's full name" do
      user.first_name = 'Ed'
      user.last_name = 'Lu'
      expect(user.full_name).to eq "Ed Lu"
    end
  end

end
