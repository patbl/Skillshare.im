class UsersController < ApplicationController
  before_action :ensure_signed_in, except: :index

  def show
    @user = User.find(params[:id])
    @proposals = @user.proposals
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
    session[:return_to] ||= request.referer
  end

  def update
    message = "Changes weren't saved."
    return redirect_to(session.delete(:return_to) || root_url, notice: message) if params[:cancel]
    if current_user.update(user_params)
      redirect_to current_user, flash: { success: "Profile updated." }
    else
      render :edit
    end
  end

  private

  def user_params
    attrs = %i[email location name about]
    params.require(:user).permit(attrs)
  end

  def ensure_signed_in
    session[:return_to] ||= request.url
    redirect_to signin_path unless current_user
  end
end
