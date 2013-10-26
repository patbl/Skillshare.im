class ProposalsController < ApplicationController
  before_action :set_proposal, only: %i[show edit update destroy]
  before_action :set_user, only: %i[new create update destroy]
  def index
    @proposals = Proposal.all
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
      render :show
    else
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to [@user, @proposal]
    else
      render :edit
    end
  end

  def destroy
    @proposal.destroy
    redirect_to user_proposals_path(@user)
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
    # @user = User.find(params[:user_id])
    @user = current_user
  end
end
