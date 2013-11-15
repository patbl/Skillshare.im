require 'spec_helper'

feature "Authentication" do
  scenario "signing in" do
    subject { page }

    visit root_url

    expect(page).to have_selector('#sign_in')

    click_link 'Sign in'

    expect(page).to have_selector('.alert-info')
    expect(page).to have_selector('#sign_out')

    click_link 'Sign Out'

    expect(page).to have_selector('.alert-info')
    expect(page).to have_selector('#sign_in')
  end
end
