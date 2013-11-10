require 'spec_helper'

feature "Authentication" do

  scenario "user hasn't signed in yet", :skip do
    subject { page }

    before { visit root_url }

    it { should have_selector('#sign_in') }

    describe "signing in" do
      before { click_link 'Sign in' }

      it "lets me know I signed in" do
        should have_selector('#notice')
        should have_selector('#sign_out')
      end

      describe "signing out" do
        before { click_link 'Sign out' }

        it "lets me know I signed out" do
          should have_selector('#notice')
          should have_selector('#sign_in')
        end
      end
    end
  end

  scenario "guest user attempts to create new proposal" do
    user = create :user

    visit new_user_proposal_path(user)
    click_link "Sign in"
    
    
  end
end
