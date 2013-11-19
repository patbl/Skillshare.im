require 'spec_helper'

feature "Authentication" do
  scenario "signing in" do
    visit root_url

    first(:link, "Sign in").click

    expect(page).to have_selector(".alert-success")
    expect(page).to have_content("Sign Out")

    click_link "Sign Out"

    expect(page).to have_selector(".alert-info")
    expect(page).to have_content("Sign in")
  end

  scenario "clicking on a link that requires that a user be signed in" do
    xu = create :user, name: "Xu Li"
    ed = create :user, name: "Ed Lu"
    visit users_path

    click_link "Xu Li"

    expect(current_path).to eq user_path(xu)

    click_link "Sign Out"

    expect(current_path).to eq root_path
  end
end
