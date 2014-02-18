class OffersController < ProposalsController
  def index
    respond_to do |format|
      format.html do
        @offers = Offer.filter_by_tag(params[:category]).page(params[:page]).per(30).decorate
      end

      format.atom do
        @offers = Offer.recent
        @updated_at = @offers.maximum(:updated_at)
      end
    end
  end

  def show
    @offer = Offer.find(params[:id]).decorate
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
      redirect_back_or user_url(current_user), success: "Offer created."
    else
      @user = current_user
      render :new
    end
  end

  def update
    if @offer.update(offer_params)
      redirect_back_or @offer, success: "Offer updated."
    else
      @user = current_user
      render :edit
    end
  end

  def destroy
    @offer.destroy
    redirect_back_or user_url(current_user), success: "Offer deleted."
  end

  private

  def offer_params
    attrs = %i[title description location category_list]
    params.require(:offer).permit(attrs)
  end

  def set_offer
    @offer = current_user.proposals.find(params[:id])
  end
end
