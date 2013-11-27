module FeatureHelpers
  def sign_in
    visit root_path
    first(:link, "Sign in").click
  end

  def create_user(new_user: false, **options)
    @user = create :user, options
    expect(User).to receive(:from_omniauth).with(anything()).and_return(@user)
    expect(@user).to receive(:new?).and_return(new_user)
    @user
  end

  def signed_in?
    page.has_content? "Sign Out"
  end

  def signed_out?
    !signed_in?
  end

  def signed_in_as?(user)
    page.has_selector?(".dropdown-menu", text: user.name)
  end
end
