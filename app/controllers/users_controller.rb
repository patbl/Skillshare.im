class UsersController < ApplicationController
  before_action :ensure_signed_in, except: :index
  before_action :ensure_current_user, only: %i[edit update]
  before_action :set_user, except: :index

  def show
    @user = User.find(params[:id])
    @proposals = @user.proposals
  end

  def index
    @users = User.all
  end

  def edit
    session[:return_to] ||= request.referer
  end

  def update
    return redirect_to(session[:return_to] || root_url) if params[:cancel]
    @user.update(user_params)
    if @user.save
      redirect_to @user
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
    redirect_to signin_path unless current_user
  end

  def ensure_current_user
    redirect_to root_url unless current_user.id == params[:id].to_i
  end

  def set_user
    @user = User.find(params[:id])
  end
end
