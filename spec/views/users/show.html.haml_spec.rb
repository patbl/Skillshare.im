require 'spec_helper'

describe "users/show.html.haml" do
  before do
    assign(:user, create(:user))
  end

  it "displays the user's proposals" do
    render
    expect(rendered).to have_css('#location')
    expect(rendered).to have_css('#email')
  end
end                                      
