class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token if Rails.env.development?

  def new
  end

  def create
    @identity = Identity.find_or_create(auth)

    if signed_in?
      if @identity.user
        # user attempts to sign in using same provider
        message = { alert: "You already signed in with that account." }
      else
        # user attempts to sign in with a different provider
        @identity.update!(user: current_user)
        message = { success: "Your accounts are now linked." }
      end
    else
      # user isn't signed in
      if @identity.user
        message = { success: "You signed in successfully." }
      else
        @user = User.find_or_create_from_auth!(auth)
        @identity.update!(user: @user)
        redirect_new_user
        message = {}
      end
      self.current_user = @identity.user
    end
    redirect_back_or root_url, message
  end

  def create_with_password
    log_in = LogInWithPassword
               .new(*password_params.values_at(:email, :password))
               .tap(&:call)

    if log_in.success?
      self.current_user = log_in.user
      redirect_back_or(root_url, success: "You signed in successfully.")
    else
      render(:new)
    end
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
    ActionController::Parameters
      .new(request.env.fetch("omniauth.auth", {}))
      .permit(:provider, :uid,
              info: [:email, :first_name, :last_name, :location, :image, urls: [:Facebook]],
              credentials: [:token, :expires_at])
  end

  def password_params
    params.require(:session).permit(:email, :password)
  end

  def redirect_new_user
    store_url edit_user_url(@user), notice: %{Thanks for signing up! Please check the information below and click "Save."}
    store_url new_user_offer_url(@user), notice: "Create your first offer now! Or click on the gift icon above to see what other people are offering."
  end
end
