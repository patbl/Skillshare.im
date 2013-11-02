require 'spec_helper'

feature "Proposal management" do
  scenario "adds a new proposal", focus: true do
    sign_in

    click_link "My offers"
    click_link "Create a new offer"

    expect do
      fill_in "Title", with: "12 cases of tinned dog food"
      fill_in "Category", with: "goods"
      fill_in "Description", with: <<-EOF
So I was tired of spending so much time preparing and consuming 
food, so I tried going on an **all–dog-food diet** for a couple of
months. It wasn't so bad, but I think my dog noticed. She
stopped listening to me.

<b>Plus</b>, I'd always finish eating before my girlfriend did, but
she'd want me to stay there so she could talk about her
co-workers or whatever. So I was like, what's the point? But I 
thought somebody else might be interested in giving it a go.
It's _one-hundred percent_ vegan, and pretty tasty, too.
EOF
      click_button "Save"
    end.to change(Proposal, :count).by(1)
    expect(page).to have_selector("#title", text: "12 cases of tinned dog food")
    expect(page).to have_content("New offer created.")
  end

  scenario "you can get good cheer anywhere" do
    sign_in
    user = User.last
    create :offer, title: "good cheer", user: user
    click_link "My offers"
    click_link "good cheer"
    click_link "Edit"
    choose "Anywhere"
    click_button "Save"
    expect(page).to have_selector("#location", text: "Anywhere")
  end

  scenario "viewing others' proposals" do
    xi = create :user, name: "Xu Li"
    create :offer, title: "stuff", user: xi
    sign_in
    click_link "stuff"
    expect(page).to have_selector("#title", "stuff")
    expect(page).to_not have_link("Edit")
    expect(page).to_not have_link("Delete")
    click_link "Xu Li"
    click_link "Xu Li's Offers"
    expect(page).to_not have_link("Create a new offer")
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
