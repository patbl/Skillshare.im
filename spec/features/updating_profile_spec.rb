require 'spec_helper'

feature "profile management" do
  scenario "canceling editing a profile" do
    sign_in
    user = User.last

    visit user_path(user)
    binding.pry
    click_button 'edit-profile'
    fill_in "E-mail", with: ""
    click_button "Save"
    click_button "Save"
    click_button "Cancel"

    expect(current_path).to eq user_path(user)
  end
end
