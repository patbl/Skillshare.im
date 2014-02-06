require 'spec_helper'

feature "visiting static pages" do
  before do
    visit root_path
  end

  scenario "visiting the 'about' page" do
    click_link "About"
    expect(page).to have_content "Patrick"
  end

  scenario "visiting the 'FAQ' page" do
    click_link "FAQ"
    expect(page).to have_content "Shakira"
  end
end
