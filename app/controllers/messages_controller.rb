class MessagesController < ApplicationController
  def new
    return redirect_to signin_path unless current_user
    @message = Message.new
    @proposal = Proposal.find(params[:proposal_id])
  end

  def create
    return redirect_to signin_path unless current_user
    @message = Message.new(message_params)
    @proposal = Proposal.find(params[:proposal_id])
    @message.assign_attributes(sender_id: current_user.id,
                               proposal_id: @proposal.id,
                               subject: @proposal.title)
    if @message.save
      UserToUser.contact(@message).deliver
      redirect_to @proposal, notice: "Message sent."
    else
      render :new
    end
  end

  private

  def message_params
    attrs = %i[body]
    params.require(:message).permit(attrs)
  end

end
