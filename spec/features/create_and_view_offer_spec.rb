require 'spec_helper'

feature "offer management", :slow do
  before { @user = sign_in }

  scenario "adds a new offer" do
    create_offer_with_form("12 Cases Of Tinned Dog Food")

    expect(page).to have_content("12 Cases Of Tinned Dog Food")
    expect(page).to have_selector(".alert")
  end

  scenario "filtering Offers" do
    create :offer, title: "love", category_list: "services"

    visit offers_path
    user_sees_n_offers 1

    filter_on_category "services"
    # save_and_open_page
    user_sees_n_offers 1

    filter_on_category "goods"
    user_sees_n_offers 0

    filter_on_category "All"
    user_sees_n_offers 1
  end

  scenario "edits a offer" do
    create(:offer, title: "Feminist Perspectives on Tort Law", user: @user)

    visit user_path(@user)
    click_link "Feminist Perspectives on Tort Law"

    click_edit_button
    fill_in "Title", with: "Feminist Perspectives in Music Therapy"
    click_button "Save"

    expect(page).to have_content("Feminist Perspectives in Music Therapy")
    expect(page).to have_content("Updated.")
  end

  scenario "deletes an offer" do
    create(:offer, title: "Feminist Perspectives on Tort Law", user: @user)

    visit user_path(@user)
    click_link "Feminist Perspectives on Tort Law"
    click_delete_button

    user_sees_n_offers 0
  end

  scenario "create a wanted", skip: true do
    visit new_user_wanted_path(@user)
  end

  def user_sees_n_offers(n)
    expect(page).to have_selector(".proposal", count: n)
  end

  def filter_on_category(services)
    within(".categories") do
      click_link services
    end
  end

  def click_edit_button
    find(:css, ".btn.btn-primary.btn-small").click
  end

  def click_delete_button
    find(:css, ".btn.btn-danger.btn-small").click
  end

  def create_offer_with_form(title, category = "goods", location = "Anywhere")
    visit new_user_offer_path(@user)
    fill_in "Title", with: title
    select category
    select location
    click_button "Create"
  end
end
