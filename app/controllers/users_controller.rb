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
  end

  def update
    if current_user.update(user_params)
      redirect_back_or(current_user, flash: { success: "Profile updated." })
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy!
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    attrs = %i[email location name about]
    params.require(:user).permit(attrs)
  end
end
