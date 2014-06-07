require 'spec_helper'

describe UpdatesSubscription do
  let(:subscription) { build(:updates_subscription, frequency: :biweekly, last_sent: Time.now) }

  describe "#secure_key" do
    it "generates a random key on creation" do
      expect(subscription.secure_key).to be nil
      subscription.save!
      expect(subscription.secure_key).to be_present
    end
  end

  describe "#due?" do
    it "is true every 14 days" do
      time = subscription.last_sent
      expect(subscription.due?(time + 14.days)).to be true
    end

    it "is false the thirteen other days" do
      last_sent = subscription.last_sent
      (1..13).each do |date_offset|
        expect(subscription.due?(last_sent + date_offset.days)).to be false
      end
    end
  end

  describe "#new_items" do
    it "returns the number of items posted since the e-mail was last sent" do
      subscription.last_sent = 2.weeks.ago
      create :offer, created_at: 3.weeks.ago
      create :wanted, created_at: 13.days.ago
      expect(subscription.new_items).to eq 1
    end
  end

  describe "#send_email!" do
    it "sets last_sent to today" do
      subscription = create :updates_subscription, last_sent: 3.weeks.ago
      subscription.send_email!
      expect(subscription.reload.last_sent).to be_same_second_as(Time.now)
    end
  end
end
