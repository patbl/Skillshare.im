class ProposalsController < ApplicationController
  include ProposalsHelper

  before_action :store_requested_url, only: :show
  before_action :ensure_signed_in, only: %i[create new edit update destroy]
  before_action :set_categories,   only: %i[create new edit update]
  before_action :set_proposal,     only: %i[edit update destroy]

  def index
    @offers = Proposal.offers.tagged_with_or_all(params[:category])
  end

  def show
    @proposal = Proposal.find(params[:id])
    @user = current_user
  end

  def new
    @proposal = current_user.proposals.new
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def create
    @proposal = current_user.proposals.build(proposal_params)
    if @proposal.save
      redirect_back_or(user_path(current_user), flash: { success: "Offer created." })
    else
      @user = current_user
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_back_or(@proposal, flash: { success: "Offer updated." })
    else
      render :edit
    end
  end

  def destroy
    @proposal.destroy
    redirect_back_or(user_path(current_user), flash: { success: "Offer deleted." })
  end

  private

  def set_categories
    @categories = ApplicationHelper::CATEGORIES
  end

  def set_proposal
    @proposal = current_user.proposals.find(params[:id])
  end

  def proposal_params
    attrs = %i[title description location offer category_list]
    params.require(:proposal).permit(attrs)
  end
end
