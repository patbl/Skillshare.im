class MessagesController < ApplicationController
  include ApplicationHelper # for Markdown

  def create
    @body = params[:message][:body]
    @proposal = Proposal.find(proposal_id).decorate
    notification_email = NotificationEmail.new(current_user, @body, @proposal)
    confirmation_email = ConfirmationEmail.new(current_user, @body, @proposal)
    UserMailer.proposal_email(notification_email).deliver
    UserMailer.proposal_email(confirmation_email).deliver
    @proposal.record(current_user)
    redirect_back_or @proposal, success: "Message sent."
  end

  protected

  def proposal_id
    params[:offer_id] || params[:wanted_id]
  end
end
