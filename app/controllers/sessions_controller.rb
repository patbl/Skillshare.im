class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token if Rails.env.development?

  def new
    redirect_to "/auth/facebook"
  end

  def create
    @identity = Identity.find_with_omniauth(auth) ||
                Identity.create_with_omniauth(auth)

    if signed_in?
      if @identity.user == current_user
        return redirect_back_or root_url, notice: "Already linked to that account!"
      else
        @identity.user = current_user
        @identity.save!
        return redirect_back_or root_url, notice: "Successfully linked account!"
      end
    else
      if @identity.user.present?
        self.current_user = @identity.user
        return redirect_back_or root_url, flash: { success: "Successfully signed in!" }
      else
        user = User.make_user(auth)
        @identity.user = user
        user.identities << @identity
        self.current_user = @identity.user
        if user.new?
          store_url edit_user_path(user), notice: "Thanks for signing up! Please check your e-mail address and location below, then click Save."
          store_url new_user_offer_path(user), notice: "Fill out this form to create your first offer."
        end
        return redirect_back_or root_url, flash: { success: "Successfully signed in!" }
      end
    end
    return_back_or(root_url, flash: { success: "You signed in successfully." })
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

  def auth
    request.env["omniauth.auth"]
  end
end
