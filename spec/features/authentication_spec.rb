require 'spec_helper'

describe "Authentication" do

  describe "signin page" do
    subject { page }
    before { visit root_url }
    it { should have_content('Facebook') }
  end

  describe "clicking on the sign-in button" do
    before { visit root_url }
    it "signs me in" do
      click_link 'Sign in'
      expect(page).to have_selector('#notice')
    end
  end

end


