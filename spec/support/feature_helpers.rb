module FeatureHelpers
  def sign_in(new_user: false, **options)
    @user = create :user, options
    expect(User).to receive(:from_omniauth).with(anything()).and_return(@user)
    expect(@user).to receive(:new?).and_return(new_user)

    visit root_path
    first(:link, "Sign in").click

    @user
  end

  def sign_in_as(user, new_user: false)
    expect(User).to receive(:from_omniauth).with(anything()).and_return(user)
    expect(user).to receive(:new?).and_return(new_user)

    visit root_path
    first(:link, "Sign in").click

    @user
  end
end
