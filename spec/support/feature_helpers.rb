module FeatureHelpers
  def sign_in
    visit root_path
    first(:link, "Sign in").click
  end
end
