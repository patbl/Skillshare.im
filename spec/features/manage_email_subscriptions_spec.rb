require 'spec_helper'

describe "Manage e-mail subscriptions" do
  context "with subscription" do
    it "allows the user to unsubscribe" do
      user = sign_in

      visit edit_user_path(user)
      expect(new_proposal_checkbox).to be_checked

      uncheck "new"
      click_button "Save"

      visit edit_user_path(user)
      expect(new_proposal_checkbox).not_to be_checked
    end

    it "allows the user to unsubscribe with one click" do
      subscription = create :subscription, active: true
      expect(subscription.active?).to be true
      visit "/unsubscribe/#{subscription.secure_key}"
      expect(subscription.reload.active?).to be false
    end
  end

  context "without subscription" do
    it "allows the user to subscribe" do
      user = sign_in

      user.subscriptions.each { |subscription| subscription.update active: false }

      visit edit_user_path(user)

      expect(new_proposal_checkbox).not_to be_checked
      check "new"
      click_button "Save"

      visit edit_user_path(user)
      expect(new_proposal_checkbox).to be_checked
    end
  end
end

def new_proposal_checkbox
  find("#new")
end
