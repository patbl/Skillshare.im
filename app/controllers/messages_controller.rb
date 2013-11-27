class MessagesController < ApplicationController
  include ApplicationHelper # for Markdown

  before_action :store_previous_url
  before_action :ensure_signed_in

  def create
    @body = params[:message][:body]
    @proposal = Proposal.find(params[:proposal_id])
    UserMailer.proposal_email(current_user, @body, @proposal).deliver
    redirect_back_or(@proposal, flash: { success: "Message sent." })
  end
end
