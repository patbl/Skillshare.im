module FeatureHelpers
  def sign_in
    visit root_path
    click_link 'Sign in'
  end
end
