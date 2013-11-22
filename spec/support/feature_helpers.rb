module FeatureHelpers
  def sign_in(new_user: false)
    @user = create :user
    expect(User).to receive(:from_omniauth).with(anything()).and_return(@user)
    expect(@user).to receive(:new?).and_return(new_user)

    visit root_path
    first(:link, "Sign in").click

    @user
  end
end
