require 'spec_helper'

describe "Authentication" do

  context "user hasn't signed in yet" do
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

end
