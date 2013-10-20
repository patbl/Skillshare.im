require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe "signin page" do
    before { visit root_url }
    it { should have_content('Facebook') }
  end

end


