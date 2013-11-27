require 'spec_helper'

feature "profile management", :slow, :skip do
  scenario "saving changes to a profile" do
    user = sign_in

    click_link user.name
    click_link "edit-profile"
    fill_in "Location", with: "Nowhere, Wyoming"
    click_button "Save"

    expect(page).to have_selector(".alert-success")

    click_link "Sign Out"
    sign_in_as user
    click_link user.name
    expect(page).to have_content("Nowhere, Wyoming")
  end
end
