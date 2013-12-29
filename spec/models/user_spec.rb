require 'spec_helper'

describe User do
  context "validations" do
    it "my user factory might not be broken" do
      expect(build(:user)).to be_valid
    end
  end
end
