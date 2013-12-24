class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token if Rails.env.development?

  def new
  end

  def create
    @identity = Identity.find_or_create(auth)

    if signed_in?
      if @identity.user == current_user
        message = { alert: "You already signed in with that account." }
      else
        @identity.update!(user: current_user)
        message = { notice: "You successfully linked your accounts!" }
      end
    else
      if @identity.user.present?
        self.current_user = @identity.user
        message = { success: "Successfully signed in!" }
      else
        user = User.make_user(auth)
        @identity.user = user
        user.identities << @identity
        self.current_user = @identity.user
        if user.new?
          store_url edit_user_path(user), notice: "Thanks for signing up! Please check your e-mail address and location below, then click Save."
          store_url new_user_offer_path(user), notice: "Fill out this form to create your first offer."
        end
        message = { success: "Successfully signed in!" }
      end
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
end
