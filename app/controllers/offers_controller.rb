class OffersController < ApplicationController
  include OffersHelper

  skip_before_action :authorize, only: %i[index show]
  before_action :set_categories, only: %i[create new edit update]
  before_action :set_offer, only: %i[edit update destroy]

  def index
    @offers = Offer.tagged_with_or_all(params[:category])

    respond_to do |format|
      format.html
      format.atom
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @user = current_user
  end

  def new
    @offer = current_user.offers.new
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def create
    @offer = current_user.offers.build(offer_params)
    if @offer.save
      redirect_back_or user_path(current_user), success: "Offer created."
    else
      @user = current_user
      render :new
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_back_or @offer, success: "Offer updated."
    else
      render :edit
    end
  end

  def destroy
    @offer.destroy
    redirect_back_or user_path(current_user), success: "Offer deleted."
  end

  private

  def set_categories
    @categories = ApplicationHelper::CATEGORIES
  end

  def set_offer
    @offer = current_user.offers.find(params[:id])
  end

  def offer_params
    attrs = %i[title description location category_list]
    params.require(:offer).permit(attrs)
  end
end
