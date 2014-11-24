require 'spec_helper'

feature "profile management", :slow do
  context "viewing a profile" do
    before do
      @user = sign_in
      @user.update name: "Lisa", about: "A nice person."
      visit user_path(@user)
    end

    scenario "Open Graph tags show up" do
      expect(page).to have_css "meta[charset='utf-8']", visible: false
      expect(page).to have_css "meta[property='og:title'][content='Lisa']", visible: false
      expect(page).to have_css "meta[property='og:description'][content='A nice person.']", visible: false
      expect(page).to have_css "meta[property='og:type'][content='profile']", visible: false

      url = URI.parse(current_url)
      expect(page).to have_css "meta[property='og:url'][content='#{url}']", visible: false

      image_url = avatar_url(@user)
      expect(page).to have_css "meta[property='og:image'][content='#{image_url}']", visible: false
    end
  end

  context "managing a profile" do
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

  end

  def user_count_equals(n)
    expect(page).to have_selector(".user-card", count: n)
  end
end
