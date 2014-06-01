require 'spec_helper'

describe SubscriptionMailer do
  describe "updates" do
    let!(:subscription) { create :updates_subscription }
    let!(:offer) { create :offer }
    let!(:old_offer) { create :offer, title: "too old", created_at: 15.days.ago }
    let!(:wanted) { create :wanted }
    let!(:mail) { described_class.updates(subscription) }

    context "instance variables" do
      it "includes recent offers " do
        expect(mail.body).to match offer.title
      end

      it "doesn't include old offers" do
        expect(mail.body).not_to match old_offer.title
      end

      it "includes recent wanteds" do
        expect(mail.body).to match wanted.title
      end
    end
  end
end
