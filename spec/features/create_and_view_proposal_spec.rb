# -*- coding: utf-8 -*-
require 'spec_helper'

feature "Proposal management", slow: true do
  scenario "adds a new proposal" do
    sign_in

    click_link "Create"

    expect do
      fill_in "Title", with: "12 cases of tinned dog food"
      select "goods", from: "Category"
      fill_in "Description", with: "Abandoned all–dog-food diet. Will ship internationally."
      choose "Anywhere"
      click_button "Save"
    end.to change(Proposal, :count).by(1)
    expect(page).to have_selector("#title", text: "12 cases of tinned dog food")
    expect(page).to have_content("New offer created.")
  end

  scenario "edits a proposal" do
    sign_in
    user = User.last
    create :offer, title: "melancholy", category_list: "lodging", user: user
    
    click_link "My offers"
    click_link "melancholy"
    click_link "Edit"

    expect(find_field("Title").value).to eq "melancholy"
    expect(find_field("Category list").value).to eq "lodging"

    fill_in "Title", with: "good cheer"
    choose "Anywhere"
    click_button "Save"

    expect(page).to have_selector("#title", text: "good cheer")
    expect(page).to have_selector("#location", text: "Anywhere")
  end

  scenario "viewing others' proposals" do
    xu = create :user, name: "Xu Li"
    create :offer, title: "stuff", user: xu

    sign_in
    click_link "stuff"

    expect(page).to have_selector("#title", "stuff")
    expect(page).to_not have_link("Edit")
    expect(page).to_not have_link("Delete")

    click_link "Xu Li"
    click_link "Xu Li's Offers"

    expect(page).to_not have_link("Create a new offer")
  end

  scenario "filtering proposals" do
    create :offer, title: "love", category_list: "services"
    create :offer, title: "encouragement", category_list: "services"
    create :offer, title: "crash pad", category_list: "lodging"

    visit root_path
    click_link "services"
    expect(page).to have_selector("#offer", count: 2)
    click_link "lodging"
    expect(page).to have_selector("#offer", count: 1)
    click_link "all"
    expect(page).to have_selector("#offer", count: 3)
    click_link "goods"
    expect(page).to_not have_selector("#offer")
  end

  scenario "edits a proposal", skip: true do
    sign_in

    user = User.last
    create(:offer, title: "Ron Paul 2012 campaign memorabilia", user: user)
    create(:offer, title: "Feminist Perspectives on Tort Law", user: user)

    visit user_proposals_path(user)
    expect(page).to have_selector("#offer", count: 2)

    click_link "Feminist Perspectives on Tort Law"
    click_link "Edit"
    fill_in "Title", with: "Feminist Perspectives in Music Therapy"
    click_button "Update"

    expect(page).to have_selector("#title", text: "Feminist Perspectives in Music Therapy")
    expect(page).to have_content("Offer updated.")
  end

  scenario "delete an offer", js: true, skip: true do

    visit users_path
    click_link "Sign in" # this seems not to be working

    # create :proposal, title: "State of Fear", user: User.last

    # visit user_proposals_path(User.last)

    # click_link "State of Fear"

    # expect {
    # click_link "Delete"
    # page.driver.browser.accept_js_confirms
    # # }.to change(Proposal, :count).by(-1)
    # # expect(page).to_not have_content("State of Fear")
  end
end
