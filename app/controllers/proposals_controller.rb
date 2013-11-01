class ProposalsController < ApplicationController
  before_action :set_user, only: %i[new create edit update destroy]
  before_action :set_proposal, only: %i[show edit update destroy]

  def index
    @user = User.find(params[:user_id])
    @offers = Proposal.offers.where(user_id: params[:user_id])
    @requests = Proposal.requests.where(user_id: params[:user_id])
  end

  def show
  end

  def new
    @proposal = Proposal.new
  end

  def edit
  end

  def create
    @proposal = Proposal.new(proposal_params)
    @proposal.user_id = current_user.id
    if @proposal.save
      flash[:notice] = "New offer created."
      render :show
    else
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to [@user, @proposal], notice: 'Offer updated.'
    else
      render :edit
    end
  end

  def destroy
    if @proposal.user.id == current_user.id || current_user.admin?
      Proposal.find(@proposal).destroy
      redirect_to user_proposals_path(@user)
    else
      redirect_to root_url, notice: "You can't do that!"
    end
  end

  private

  def proposal_params
    attrs = %i[title description location category offer]
    params.require(:proposal).permit(attrs)
  end

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def set_user
    @user = current_user
    redirect_to signin_path unless @user
  end
end
