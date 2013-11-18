require 'spec_helper'

feature "Authentication", skip: true do
  scenario "signing in" do
    subject { page }

    visit root_url

    expect(page).to have_content("Sign in")

    first(:link, "Sign in").click

    expect(page).to have_selector(".alert-success")
    expect(page).to have_content("Sign Out")

    click_link "Sign Out"

    expect(page).to have_selector(".alert-info")
    expect(page).to have_content("Sign in")
  end
end
