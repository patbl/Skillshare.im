class ProposalsController < ApplicationController
  include ProposalsHelper

  before_action :ensure_signed_in, only: %i[create new edit update destroy]
  before_action :set_categories,   only: %i[create new edit update]
  before_action :set_proposal,     only: %i[edit update destroy]
  before_action :check_for_cancel, only: %i[create update]

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
    session[:return_to] ||= request.referer
  end

  def edit
    @user = current_user
  end

  def create
    @proposal = current_user.proposals.build(proposal_params)
    if @proposal.save
      redirect_to user_path(current_user), flash: { success: "Offer created." }
    else
      @user = current_user
      render :new
    end
  end

  def update
    if @proposal.update(proposal_params)
      redirect_to user_path(current_user), flash: { success: "Offer updated." }
    else
      render :edit
    end
  end

  def destroy
    @proposal.destroy
    redirect_to user_path(current_user), flash: { success: "Offer deleted." }
  end

  def map
    @marker_data = Proposal.recent(50).mappable.map do |proposal|
      link = ActionController::Base.helpers.link_to(proposal.title, proposal_path(proposal))
      icon = category_tag(proposal.category)
      { latlng: proposal.latlng, popup: "#{icon} #{link}" }
    end
  end

  private

  def ensure_signed_in
    redirect_to signin_path unless current_user
  end

  def set_categories
    @categories = ApplicationHelper::CATEGORIES
  end

  def set_proposal
    @proposal = current_user.proposals.find(params[:id])
  end

  def check_for_cancel
    message = %{Offer wasn't #{params[:action] == "create" ? "saved" : "updated"}.}
    redirect_to(session.delete(:return_to) || root_path, notice: message) if params[:cancel]
  end

  def proposal_params
    attrs = %i[title description location offer category_list]
    params.require(:proposal).permit(attrs)
  end
end
