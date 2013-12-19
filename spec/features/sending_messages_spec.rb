require 'spec_helper'

feature "sending messages", :slow do
  scenario "from proposals index page" do
    recipient = create_user name: "Xi"
    offer = create :offer, user: recipient, title: "500 Records"
    create_user name: "Ed"
    sign_in

    click_button "Send"
    expect(page).to have_selector(".alert-success")
    expect(current_path).to eq proposal_path(offer)
  end

  scenario "from proposal show page" do
    recipient = create_user name: "Xi"
    offer = create :offer, user: recipient, title: "500 Records"
    create_user name: "Ed"
    sign_in
    visit proposals_path(offer)

    click_button "Send"
    expect(page).to have_selector(".alert-success")
    expect(current_path).to eq proposal_path(offer)
  end

  scenario "not logged in", skip: true do
    ed = create_user name: "Ed"
    offer = create :offer, user: ed, title: "coffee"
    create_user name: "Xi"

    visit root_path
    click_link "coffee"
    click_link "Sign in to request"
    expect(current_path).to eq proposal_path(offer)
  end
end
