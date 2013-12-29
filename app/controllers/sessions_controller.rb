class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token if Rails.env.development?

  def new
    redirect_to facebook_auth_url
  end

  def create
    @identity = Identity.find_or_create(auth)

    message = if signed_in?
                if @identity.user == current_user
                  # user attempts to sign in using same provider
                  { alert: "You already signed in with that account." }
                else
                  # user attempts to sign in with a different provider
                  @identity.update!(user: current_user)
                  { success: "Your accounts are now linked." }
                end
              else
                # user isn't signed in
                unless @identity.user
                  # user doesn't have an account
                  @user = User.create_from_auth(auth)
                  @identity.update(user: @user)
                  redirect_new_user
                end
                self.current_user = @identity.user
                { success: "You signed in." }
              end
    redirect_back_or root_url, message
  end

  def failure
    redirect_to root_url, error: "You didn't sign in."
  end

  def destroy
    session.delete(:user_id)
    session.delete(:return_to)
    redirect_to root_url, notice: "You signed out successfully."
  end

  protected

  def auth
    request.env["omniauth.auth"]
  end

  def redirect_new_user
    store_url edit_user_url(@user), notice: "Thanks for signing up! Please check your e-mail address and location below, then click Save."
    store_url new_user_offer_url(@user), notice: "Fill out this form to create your first offer."
  end
end
