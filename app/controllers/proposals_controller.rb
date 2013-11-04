class ProposalsController < ApplicationController
  before_action :ensure_signed_in, only: %i[create new edit update destroy]
  before_action :set_proposal,     only: %i[edit show update destroy]
  before_action :set_user_from_params, only: %i[index create new]
  before_action :set_user_from_proposal, only: %i[edit show update destroy]
  before_action :verify_user,      only: %i[create new edit update destroy]

  def index
    @offers = Proposal.offers.where(user_id: params[:user_id])
    @requests = Proposal.requests.where(user_id: params[:user_id])
  end

  def show
  end

  def new
    @proposal = Proposal.new
    @categories = ApplicationHelper::CATEGORIES
  end

  def edit
    @categories = ApplicationHelper::CATEGORIES
  end

  def create
    @proposal = Proposal.new(proposal_params.merge(user_id: params[:user_id]))
    if @proposal.save
      flash[:notice] = "New offer created."
      render :show
    else
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to @proposal, notice: "Offer updated."
    else
      render :edit
    end
  end

  def destroy
    @proposal.destroy
    redirect_to user_proposals_path(@user)
  end

  def filter
    @offers = if params[:category]
                Proposal.offers.tagged_with(params[:category])
              else
                Proposal.offers
              end
  end

  private

  def ensure_signed_in
    redirect_to signin_path unless current_user
  end

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def set_user_from_params
    @user = User.find(params[:user_id])
  end

  def set_user_from_proposal
    @user = @proposal.user
  end

  def verify_user
    redirect_to root_path unless @user == current_user
  end

  def proposal_params
    attrs = %i[title description location offer category_list]
    params.require(:proposal).permit(attrs)
  end

end
