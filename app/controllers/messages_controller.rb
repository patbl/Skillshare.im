class MessagesController < ApplicationController
  include ApplicationHelper # for markdown

  before_action :ensure_signed_in

  def create
    @body = params[:message][:body]
    @proposal = Proposal.find(params[:proposal_id])
    UserMailer.proposal_email(current_user, @body, @proposal).deliver
    redirect_to @proposal, flash: { success: "Message sent." }
  end

  private

  def ensure_signed_in
    redirect_to signin_path unless current_user
  end
end
