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
    user = create :user
    expect(User).to receive(:from_omniauth).with(anything()).and_return(user)
    expect(user).to receive(:new?).and_return(false)
    xu = create :user, name: "Xu Li"
    visit users_path

    click_link "Xu Li"

    expect(current_path).to eq user_path(xu)

    click_link "Sign Out"

    expect(current_path).to eq root_path
  end
end
