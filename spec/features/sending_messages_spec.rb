require 'spec_helper'

feature "sending messages", :slow do
  scenario "sending a message about an offer" do
    recipient = create_user name: "Xi"
    offer = create :offer, user: recipient, title: "500 Records"
    create_user name: "Ed"
    sign_in

    click_button "Send"
    expect(page).to have_selector(".alert-success")
    expect(current_path).to eq proposal_path(offer)
  end
end
