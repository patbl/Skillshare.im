require 'spec_helper'

feature "sending messages", :slow do
  scenario "from Offers index page" do
    recipient = create_user name: "Xi"
    offer = create :offer, user: recipient, title: "500 Records"
    create_user name: "Ed"
    sign_in

    click_button "Send"
    expect(page).to have_selector(".alert-success")
    expect(current_path).to eq offer_path(offer)
  end

  scenario "from offer show page" do
    recipient = create_user name: "Xi"
    offer = create :offer, user: recipient, title: "500 Records"
    create_user name: "Ed"
    sign_in
    visit offers_path(offer)

    click_button "Send"
    expect(page).to have_selector(".alert-success")
    expect(current_path).to eq offer_path(offer)
  end
end
