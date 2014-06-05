require 'spec_helper'

describe UpdatesSubscription do
  let(:subscription) { build(:updates_subscription, frequency: :biweekly, last_sent: Date.today) }
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
      date = subscription.last_sent
      expect(subscription.due?(date + 14)).to be true
    end

    it "is false the thirteen other days" do
      last_sent = subscription.last_sent
      (1..13).each do |date_offset|
        expect(subscription.due?(last_sent + date_offset)).to be false
      end
    end
  end

  describe "#new_items" do
    it "returns the number of items posted since the e-mail was last sent" do
      subscription.last_sent = 2.weeks.ago
      create :offer, created_at: 3.weeks.ago
      create :wanted, created_at: 13.days.ago + 10 # add ten seconds
      expect(subscription.new_items).to eq 1
    end
  end

  describe "#enough_new_items?" do
    describe "when there are at least four items" do
      it "returns true" do
        subscription.stub(:new_items).and_return(4)
        expect(subscription.enough_new_items?).to be true
      end
    end

    describe "when there are fewer than four items" do
      it "returns false" do
        subscription.stub(:new_items).and_return(3)
        expect(subscription.enough_new_items?).to be false
      end
    end
  end

  describe "#send_email!" do
    xit "sets last_sent to today" do
      subscription = create :updates_subscription, last_sent: 3.weeks.ago
      subscription.send_email!
      p subscription.reload.last_sent
      p subscription.reload.last_sent.today?
      expect(subscription.reload.last_sent.today?).to be true
    end
  end
end
