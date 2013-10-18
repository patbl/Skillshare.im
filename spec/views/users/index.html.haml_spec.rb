require 'spec_helper'

describe "users/index.html.haml" do
  let!(:three_users) { 3.times.collect create(:user) }

  it "should display all the users" do
    visit '/users'
    expect(page).to have_css('#user', count: 3)
  end
end
