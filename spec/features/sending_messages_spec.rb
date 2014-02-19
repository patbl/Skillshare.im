require 'spec_helper'

feature "sending messages", :slow do
  before do
    recipient = create_user
    @offer = create :offer, user: recipient
    create_user
    sign_in
  end

  scenario "from offers index page" do
    click_button "Send"

    expect(page).to have_selector(".alert-success")
    expect(current_path).to eq offer_path(@offer)
  end

  scenario "from offer show page" do
    visit proposals_path(@offer)
    click_button "Send"

    expect(page).to have_selector(".alert-success")
    expect(current_path).to eq offer_path(@offer)
  end
end
