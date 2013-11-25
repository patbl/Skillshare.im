require 'spec_helper'

feature "sending messages", :skip do
  scenario "sending a message about an offer" do
    recipient = create :user, name: "Xi Li"
    create :offer, user: recipient, title: "500 Records"
    sign_in

    click_link "500 Records"
    click_link "Request"
    click_button "Send"
    expect(page).to have_selector(".alert-danger")
    fill_in("Message", with: "hullo there!")
    click_button "Send"

    expect(page).to have_content("Message sent.")
  end
end
