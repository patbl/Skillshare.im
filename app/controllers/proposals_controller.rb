class ProposalsController < ApplicationController
  include ProposalsHelper

  skip_before_action :authorize, only: %i[index show]
  before_action :set_categories, only: %i[create new edit update]
  before_action :set_offer, only: %i[edit update destroy]

  def index
    respond_to do |format|
      format.html do
        @proposals = Proposal.where(type: params[:type]).
          filter_by_tag(params[:category]).page(params[:page]).per(30).decorate
      end

      format.atom do
        @proposals = Proposal.recent
        @updated_at = @proposals.maximum(:updated_at)
      end
    end

  end

  def new
    type = params[:type].underscore.pluralize
    @proposal = current_user.public_send(type).new
    # @user = current_user
  end

  def edit
  end

  def create
    type = params[:type].underscore.pluralize
    @proposal = current_user.public_send(type).build(proposal_params)
    if @proposal.save
      redirect_back_or user_url(current_user), success: "Offer created."
    else
      @user = current_user
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_back_or @proposal, success: "Offer updated."
    else
      @user = current_user
      render :edit
    end
  end

  def destroy
    @proposal.destroy
    redirect_back_or user_url(current_user), success: "Offer deleted."
  end

  private

  def set_categories
    @categories = ApplicationHelper::CATEGORIES
  end

  def set_offer
    @proposal = current_user.proposals.find(params[:id])
  end

  def proposal_params
    attrs = %i[title description location category_list]
    params.require(:proposal).permit(attrs)
  end
end
