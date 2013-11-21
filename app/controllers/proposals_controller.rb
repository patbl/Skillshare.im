class ProposalsController < ApplicationController
  before_action :ensure_signed_in,       only: %i[create new edit update destroy]
  before_action :set_categories,         only: %i[create new edit update]
  before_action :set_proposal,           only: %i[edit show update destroy]
  before_action :set_user_from_params,   only: %i[index create new]
  before_action :set_user_from_proposal, only: %i[edit show update destroy]
  before_action :check_for_cancel,       only: %i[create update]
  before_action :verify_user,            only: %i[create update destroy]

  def index
    @offers = Proposal.offers.where(user_id: @user)
    @requests = Proposal.requests.where(user_id: @user)
  end

  def show
  end

  def new
    @proposal = Proposal.new
    session[:return_to] ||= request.referer
  end

  def edit
  end

  def create
    @proposal = @user.proposals.build(proposal_params)
    if @proposal.save
      flash[:success] = "New offer created."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to user_path(@user), flash: { success: "Offer updated." }
    else
      render :edit
    end
  end

  def destroy
    @proposal.destroy
    redirect_to user_path(@user), flash: { success: "proposal was deleted"}
  end

  def filter
    @offers = Proposal.offers.tagged_with_or_all(params[:category])
  end

  def map
    @center = { latlng: [52, -20], zoom: 2 }
    @markers = Proposal.recent(50).map do |proposal|
      link = ActionController::Base.helpers.link_to(proposal.title, proposal_path(proposal))
      { latlng: proposal.latlng, popup: link }
    end
  end

  private

  def ensure_signed_in
    redirect_to signin_path unless current_user
  end

  def check_for_cancel
    redirect_to(session.delete(:return_to) || root_path, notice: "Offer wasn't updated.") if params[:cancel]
  end

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end

  def set_categories
    @categories = ApplicationHelper::CATEGORIES
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
