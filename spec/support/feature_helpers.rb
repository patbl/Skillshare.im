module FeatureHelpers
  def sign_in
    visit facebook_auth_path
  end

  def create_user(new_user: false, **options)
    @user = create :user, options
    User.stub(:make_user).with(anything).and_return(@user)
    @user.stub(:new?) { new_user }
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
