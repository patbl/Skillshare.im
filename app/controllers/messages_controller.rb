class MessagesController < ApplicationController
  def new
    return redirect_to signin_path unless current_user
    @message = Message.new
    @user = User.find(params[:user_id])
  end

  def create
    return redirect_to signin_path unless current_user
    @message = Message.new(message_params)
    @message.assign_attributes(sender_id: current_user.id, recipient_id: params[:user_id])
    if @message.save
      UserToUser.contact(@message).deliver
      redirect_to user_path(User.find(params[:user_id]))
    else
      render :new
    end
  end

  private

  def message_params
    attrs = %i[subject body]
    params.require(:message).permit(attrs)
  end

end
