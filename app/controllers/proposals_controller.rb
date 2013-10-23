class ProposalsController < ApplicationController
  def index
    @proposals = Proposal.all
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def new
    @proposal = Proposal.new
  end

  def edit
    @proposal = Proposal.find(params[:id])
  end

  def create
    @proposal = Proposal.new(proposal_params)
    if @proposal.save
      render :show
    else
      render :new
    end
  end

  def update
    @proposal = Proposal.find(params[:id])
    if @proposal.update_attributes(proposal_params)
      @user = User.find(params[:user_id])
      redirect_to [@user, @proposal]
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    Proposal.find(params[:id]).destroy
    redirect_to user_proposals_path(@user)
  end

  private

  def proposal_params
    attrs = %i[title body location category offer]
    params.require(:proposal).permit(attrs)
  end
end
