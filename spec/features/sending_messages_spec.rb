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
end
