class UsersController < ApplicationController
  skip_before_action :authorize, only: %i[index map show]

  def show
    @user = User.find(params[:id]).decorate
    @proposals = @user.proposals.decorate
  end

  def index
    @users = User.order(:first_name, :last_name).page(params[:page]).per(30).decorate
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
    params.require(:user).permit(
      :email,
      :location,
      :first_name,
      :last_name,
      :ea_profile,
      :about,
      subscriptions_attributes: [:id, :active],
      password_identity_attributes: [:id, :password, :password_confirmation],
    ).tap do |permitted_params|
      if permitted_params.dig(:password_identity_attributes, :password).blank?
        permitted_params.delete("password_identity_attributes")
      end
    end
  end

  def generate_marker_data
    @marker_data = User.mappable.pluck(
      :id, :first_name, :last_name, :latitude, :longitude).map do |id, first_name, last_name, lat, lng|
        link = ActionController::Base.helpers.link_to("#{first_name} #{last_name}", user_path(id))
        { latlng: [lat, lng], popup: link.html_safe, icon: "user" }
    end
  end
end
