require 'spec_helper'

feature "profile management", :slow do
  scenario "saving changes to a profile" do
    user = sign_in
    visit user_path(user)

    find("#edit-profile").click
    fill_in "Location", with: ""
    click_button "Save"

    fill_in "Location", with: "Nowhere, Wyoming"
    click_button "Save"

    expect(page).to have_selector(".alert-success")
    expect(page).to have_content("Nowhere, Wyoming")
  end

  scenario "deleting profile" do
    user = sign_in

    visit edit_user_path(user)
    click_link "Delete Account"

    expect(current_path).to eq root_path
  end
end
