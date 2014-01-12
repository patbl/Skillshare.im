class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[index map]

  def show
    @user = User.find(params[:id]).decorate
    @offers = @user.offers.decorate
  end

  def index
    @users = User.all.order(:name).decorate
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

  def map
    @marker_data = User.mappable.pluck(:id, :name, :latitude, :longitude).map do |id, name, lat, lng|
      link = ActionController::Base.helpers.link_to(name, user_path(id))
      { latlng: [lat, lng], popup: link.html_safe, icon: "user" }
    end
  end

  private

  def user_params
    attrs = %i[email location name about]
    params.require(:user).permit(attrs)
  end
end
