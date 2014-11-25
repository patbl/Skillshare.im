class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[index map]

  def show
    @user = User.find(params[:id]).decorate
    @proposals = @user.proposals.decorate
  end

  def index
    @users = User.order(:name).page(params[:page]).per(30).decorate
    generate_marker_data if params[:page].nil? || params[:page] == 1
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_back_or current_user, success: "Profile updated."
    else
      @user = current_user
      render :edit
    end
  end

  def destroy
    current_user.destroy!
    reset_session
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :location, :first_name, :last_name, :ea_profile, :about, subscriptions_attributes: [:id, :active])
  end

  def generate_marker_data
    @marker_data = User.mappable.pluck(:id, :name, :latitude, :longitude).map do |id, name, lat, lng|
        link = ActionController::Base.helpers.link_to(name, user_path(id))
        { latlng: [lat, lng], popup: link.html_safe, icon: "user" }
    end
  end
end
