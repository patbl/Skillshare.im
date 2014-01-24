module FeatureHelpers
  def sign_in(new_user: false)
    identity = create(:identity_with_user)
    allow(Identity).to receive(:find_or_create).and_return(identity) unless new_user
    visit facebook_auth_path
    identity.user
  end

  def create_user(**options)
    user = create :user, options
    identity = create :identity, user: user
    allow(Identity).to receive(:find_or_create).and_return(identity)
    user
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
