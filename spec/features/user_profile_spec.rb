require 'spec_helper'

feature "profile management", :slow do
  before do
    @user = sign_in
    visit user_path(@user)
    find("#edit-profile").click
  end

  scenario "saving changes to a profile" do
    fill_in "Location", with: ""
    click_button "Save"

    fill_in "Location", with: "Nowhere, Wyoming"
    click_button "Save"

    expect(page).to have_selector(".alert-success")
    expect(page).to have_content("Nowhere, Wyoming")

    visit users_path
    user_count_equals 1
  end

  scenario "user deleting own profile" do
    click_link "Delete Account"

    expect(current_path).to eq root_path

    visit users_path
    user_count_equals 0
  end

  scenario "admin deleting user's profile" do
    @user.destroy!

    visit root_path
  end

  def user_count_equals(n)
    expect(page).to have_selector(".user-card", count: n)
  end
end
