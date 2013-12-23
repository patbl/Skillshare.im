require 'spec_helper'

feature "Offer management", :skip, :slow do
  before { sign_in }

  scenario "adds a new offer" do
    visit new_user_proposal_path(@user)

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

  scenario "edits a offer" do
    create :offer, title: "melancholy", category_list: "services", user: @user

    visit user_path(@user)
    click_link "Melancholy"
    click_link "Edit"

    expect(find_field("Title").value).to eq "melancholy"
    expect(find_field("Category list").value).to eq "services"

    fill_in "Title", with: "good cheer"
    choose "Anywhere"
    click_button "Save"

    expect(page).to have_content("Good Cheer")
    expect(page).to have_content("Anywhere")
  end

  scenario "canceling a new offer" do
    visit map_path
    click_link "new-offer"
    click_button "Save"
    click_button "Cancel"

    expect(current_path).to eq map_path
  end

  scenario "canceling editing a offer" do
    create :offer, title: "stuffed animals", user: @user

    visit root_url
    click_link "Stuffed Animals"
    click_link "Edit"

    fill_in "Title", with: ""
    click_button "Save"
    click_button "Save"
    click_button "Cancel"

    expect(page).to have_content("Offer wasn't updated.")
  end

  scenario "view others' Offers" do
    xu = create :user, name: "Xu Li"
    create :offer, title: "Stuff", user: xu

    visit current_path
    click_link "Stuff"

    expect(page).to have_content("Stuff")
    expect(page).to_not have_link("Edit")
    expect(page).to_not have_link("Delete")

    click_link "Xu Li"
    expect(page).to_not have_link("Create a new offer")

    visit user_path(@user)
    expect(page).to have_link("Create a new offer")
  end

  scenario "filtering Offers" do
    create :offer, title: "love", category_list: "services"
    create :offer, title: "encouragement", category_list: "services"
    create :offer, title: "crash pad", category_list: "lodging"

    visit root_path
    first(:link, "services").click
    expect(page).to have_selector(".offer", count: 2)
    click_link "lodging"
    expect(page).to have_selector(".offer", count: 1)
    click_link "All"
    expect(page).to have_selector(".offer", count: 3)
    click_link "goods"
    expect(page).to_not have_selector(".offer")
  end

  scenario "edits a offer" do
    create(:offer, title: "Feminist Perspectives On Tort Law", user: @user)

    visit user_path(@user)
    click_link "Feminist Perspectives On Tort Law"
    click_link "Edit"
    fill_in "Title", with: "Feminist Perspectives In Music Therapy"
    click_button "Save"

    expect(page).to have_content("Feminist Perspectives In Music Therapy")
    expect(page).to have_content("Offer updated.")
  end

  scenario "delete an offer", js: true do
    find("#new-offer").trigger("click")

    fill_in "Title", with: "Dog Food"
    choose "goods"
    fill_in "Description", with: "Abandoned all–dog-food diet. Will ship internationally."
    click_button "Save"

    click_link "Dog Food"
    click_link "Delete"

    expect(page).to_not have_content("Dog Food")
  end
end
