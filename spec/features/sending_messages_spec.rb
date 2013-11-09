require 'spec_helper'

feature "sending messages" do
  scenario "one user sending a message to another", slow: true do
    sign_in

    sender = User.last
    recipient = create :user, name: "Ed Lu"
    
    visit users_path
    click_link "Ed Lu"
    click_link "Send"

    fill_in "Subject", with: "50 lb. sack of MSG"
    fill_in "Body", with: "Closing down my failed Chinese restaurant."
    click_button "Create Message"
    expect(last_email.to).to include(recipient.email)
    expect(current_path).to eq user_path(recipient)
  end
end
