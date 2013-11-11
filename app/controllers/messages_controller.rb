class MessagesController < ApplicationController
  include ApplicationHelper # for markdown

  def new
    return redirect_to signin_path unless current_user
    @proposal = Proposal.find(params[:proposal_id])
  end

  def create
    return redirect_to signin_path unless current_user
    @body = params[:message][:body]
    @proposal = Proposal.find(params[:proposal_id])
    if @body.blank?
      render :new, notice: "Message can't be blank."
    else
      send_notification
      redirect_to @proposal, notice: "Message sent."
    end
  end

  private

  def send_notification
    @recipient = @proposal.user
    @sender = current_user
    subject = "#{current_user.name} sent you a message about #{@proposal.title}:"
    @sender.send_message(@recipient, markdown(@body), subject)
  end
end
