require 'spec_helper'

feature "sending messages" do
  scenario "sending a message about an offer" do
    sign_in

    sender = User.last
    recipient = create :user, name: "Xi Li"
    offer = create :offer, user: recipient, title: "500 LPs"

    visit root_path
    click_link "500 LPs"
    click_link "Send"

    fill_in "Message", with: "Upgrading to eight-tracks"
    click_button "Send"

    expect(page).to have_content("Message sent.")
  end
end
