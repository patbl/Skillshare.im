class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) # probably should restrict access to e-mail address
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.id.to_s == params[:id]
      User.find(current_user).update(user_params)
      redirect_to current_user
    else
      redirect_to root_url
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

  def user_params
    attrs = %i[email location name about]
    params.require(:user).permit(attrs)
  end
end
