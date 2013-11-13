require 'spec_helper'

feature "profile management" do
  scenario "canceling editing a profile" do
    sign_in
    user = User.last

    visit proposals_path
    click_link user.name
    click_link "Edit"
    fill_in "E-mail", with: ""
    click_button "Save"
    click_button "Save"
    click_button "Cancel"

    expect(current_path).to eq user_path(user)
  end
end
