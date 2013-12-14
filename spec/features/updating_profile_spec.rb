require 'spec_helper'

feature "profile management", :slow => false do
  scenario "saving changes to a profile" do
    user = create_user
    sign_in

    click_link user.name
    click_link "edit-profile"
    fill_in "Location", with: "Nowhere, Wyoming"
    click_button "Save"

    expect(page).to have_selector(".alert-success")
    expect(page).to have_content("Nowhere, Wyoming")
  end

  scenario "deleting profile" do
    user = create_user
    sign_in

    visit edit_user_path(user)
    click_link "Delete Account"

    expect(current_path).to eq root_path
  end
end
