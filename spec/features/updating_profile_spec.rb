require 'spec_helper'

feature "profile management" do
  scenario "canceling editing a profile" do
    sign_in
    user = User.last

    click_link user.name
    click_link "edit-profile"
    fill_in "E-mail", with: ""
    click_button "Save"
    click_button "Save"
    click_button "Cancel"

    expect(current_path).to eq user_path(user)
  end

  scenario "saving changes to a profile" do
    sign_in
    user = User.last

    click_link user.name
    click_link "edit-profile"
    fill_in "E-mail", with: "coolchick427@hotmail.com"
    click_button "Save"

    expect(page).to have_selector(".alert-success")
    expect(user.reload.email).to eq "coolchick427@hotmail.com"
  end
end
