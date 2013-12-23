class OffersController < ApplicationController
  include OffersHelper

  before_action :ensure_signed_in, only: %i[create new edit update destroy]
  before_action :set_categories,   only: %i[create new edit update]
  before_action :set_offer,        only: %i[edit update destroy]

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
    @offer = current_user.offers.build(proposal_params)
    if @offer.save
      redirect_back_or(user_path(current_user), flash: { success: "Offer created." })
    else
      @user = current_user
      render :new
    end
  end

  def update
    if @offer.update(proposal_params)
      redirect_back_or(@offer, flash: { success: "Offer updated." })
    else
      render :edit
    end
  end

  def destroy
    @offer.destroy
    redirect_back_or(user_path(current_user), flash: { success: "Offer deleted." })
  end

  private

  def set_categories
    @categories = ApplicationHelper::CATEGORIES
  end

  def set_offer
    @offer = current_user.offers.find(params[:id])
  end

  def proposal_params
    attrs = %i[title description location offer category_list]
    params.require(:offer).permit(attrs)
  end
end