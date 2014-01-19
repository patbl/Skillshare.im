require 'spec_helper'

feature "offer management", :slow do
  before do
    @user = sign_in
  end

  scenario "adds a new offer" do
    visit new_user_offer_path(@user)

    expect do
      fill_in "Title", with: "12 Cases Of Tinned Dog Food"
      select "goods"
      fill_in "Description", with: "Abandoned all–dog-food diet. Will ship internationally."
      select "Anywhere"
      click_button "Create"
    end.to change(Offer, :count).by(1)
    expect(page).to have_content("12 Cases Of Tinned Dog Food")
    expect(page).to have_selector(".alert")
  end

  scenario "filtering Offers" do
    create :offer, title: "love", category_list: "services"
    create :offer, title: "encouragement", category_list: "services"
    create :offer, title: "crash pad", category_list: "lodging"

    visit root_path
    first(:link, "services").click
    expect(page).to have_selector(".proposal", count: 2)
    click_link "lodging"
    expect(page).to have_selector(".proposal", count: 1)
    click_link "All"
    expect(page).to have_selector(".proposal", count: 3)
    click_link "goods"
    expect(page).to_not have_selector(".proposal")
  end

  scenario "edits a offer" do
    create(:offer, title: "Feminist Perspectives On Tort Law", user: @user)

    visit user_path(@user)
    click_link "Feminist Perspectives On Tort Law"
    save_and_open_page
    find(:css, ".btn.btn-primary.btn-small").click
    fill_in "Title", with: "Feminist Perspectives In Music Therapy"
    click_button "Save"

    expect(page).to have_content("Feminist Perspectives In Music Therapy")
    expect(page).to have_content("Offer updated.")
  end
end
