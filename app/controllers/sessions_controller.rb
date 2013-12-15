class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token if Rails.env.development?

  def new
    redirect_to "/auth/facebook"
  end

  def create
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id
    if user.new?
      store_url edit_user_path(user), notice: "Thanks for signing up! Please check your e-mail address and location below, then click Save."
      store_url new_user_proposal_path(user), notice: "Fill out this form to create your first offer."
    end
    redirect_back_or(root_url, flash: { success: "You signed in successfully." })
  end

  def failure
    redirect_to root_url, flash: { error: "You didn't sign in." }
  end

  def destroy
    session.delete(:user_id)
    session.delete(:return_to)
    redirect_to root_url, notice: "You signed out successfully."
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
