require 'spec_helper'

describe UpdatesSubscription do
  let(:subscription) { build(:updates_subscription, frequency: :biweekly) }
  describe "validations" do
    context "invalid subscription" do
      it "requires a user" do
        subscription.user = nil
        expect(subscription).not_to be_valid
      end
    end

    context "valid subscription" do
      it "requires a user" do
        expect(subscription).to be_valid
      end
    end
  end

  describe "#secure_key" do
    it "generates a random key on creation" do
      expect(subscription.secure_key).to be nil
      subscription.save!
      expect(subscription.secure_key).to be_present
    end
  end

  describe "#due?" do
    it "is true every 14 days" do
      date = Date.new(1970, 1, 1)
      expect(subscription.due?(date)).to be true
    end

    it "is false the thirteen other days" do
      (2..14).each do |day|
        date = Date.new(1970, 1, day)
        expect(subscription.due?(date)).to be false
      end
    end
  end

  describe "#new_stuff" do
    it "returns the number of items posted in the last two weeks" do
      create :offer, created_at: 3.weeks.ago
      new_wanted = create :wanted, created_at: 13.days.ago + 10 # add ten seconds
      expect(subscription.new_items).to eq 1
    end
  end
end
