require 'spec_helper'

feature "Authentication", :slow do
  scenario "signing in" do
    sign_in
    expect(signed_in?).to be true

    click_link "Sign Out"
    expect(signed_out?).to be true
  end

  scenario "signing in with a password" do
    user = create(:user, email: "shakira@gmail.com", first_name: "Shakira", last_name: "Mebarak Ripoll")
    create(:password_identity, password: "hunter2", user: user)

    visit sign_in_path
    expect(page).to have_content "sign in with e-mail"
    fill_in("Email", with: "shakira@gmail.com")
    fill_in("Password", with: "hunter2")
    click_button "Sign in"
    expect(page).to have_content "Shakira Mebarak Ripoll"
    expect(page.current_path).to eq(root_path)
  end

  scenario "new user can customize e-mail address and location" do
    sign_in new_user: true
    user = User.last

    expect(current_path).to eq edit_user_path(user)
    expect(page).to have_content("Please check")

    fill_in "E-mail", with: "cool_gurl427@hotmail.com"
    click_button "Save"

    expect(current_path).to eq new_user_offer_path(user)
    click_button "Create"
  end
end
