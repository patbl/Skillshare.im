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
    return redirect_to(session[:return_to] || root_url) if params[:cancel]
    if current_user.update(user_params)
      redirect_to current_user, flash: { success: "Profile updated." }
    else
      render :edit
    end
  end

  def destroy
    if current_user.admin?
      User.find(params[:id]).destroy
      redirect_to users_path, notice: "User successfully deleted."
    else
      redirect_to root_url
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
