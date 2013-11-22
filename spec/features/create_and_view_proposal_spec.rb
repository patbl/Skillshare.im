require 'spec_helper'

feature "Proposal management", slow: true do
  before { sign_in }

  scenario "adds a new proposal" do
    visit new_user_proposal_path(@user)

    expect do
      fill_in "Title", with: "12 Cases Of Tinned Dog Food"
      choose "goods"
      fill_in "Description", with: "Abandoned all–dog-food diet. Will ship internationally."
      choose "Anywhere"
      click_button "Save"
    end.to change(Proposal, :count).by(1)
    expect(page).to have_content("12 Cases Of Tinned Dog Food")
    expect(page).to have_content("New offer created.")
  end

  scenario "edits a proposal" do
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

  scenario "canceling a new proposal" do
    visit map_path
    click_link "new-proposal"
    click_button "Save"
    click_button "Cancel"

    expect(current_path).to eq map_path
  end

  scenario "canceling editing a proposal" do
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

  scenario "view others' proposals" do
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

  scenario "filtering proposals" do
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

  scenario "edits a proposal" do
    create(:offer, title: "Feminist Perspectives on Tort Law", user: @user)

    visit user_proposals_path(@user)
    expect(page).to have_selector("#offer", count: 1)

    click_link "Feminist Perspectives on Tort Law"
    click_link "Edit"
    fill_in "Title", with: "Feminist Perspectives In Music Therapy"
    click_button "Save"

    expect(page).to have_content("Feminist Perspectives In Music Therapy")
    expect(page).to have_content("Offer updated.")
  end

  scenario "delete an offer", js: true do
    find("#new-proposal").trigger("click")
    
    fill_in "Title", with: "Dog Food"
    choose "goods"
    fill_in "Description", with: "Abandoned all–dog-food diet. Will ship internationally."
    click_button "Save"

    click_link "Dog Food"
    click_link "Delete"
    
    expect(page).to_not have_content("Dog Food")
  end
end
