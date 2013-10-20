require 'spec_helper'

describe "users/index.html.haml" do
  before do
    assign(:users, create_list(:user, 3)) 
  end

  it "should display all the users" do
    render
    expect(rendered).to have_css('#user', count: 3)
  end
end
