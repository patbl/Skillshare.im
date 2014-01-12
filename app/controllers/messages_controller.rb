class MessagesController < ApplicationController
  include ApplicationHelper # for Markdown

  def create
    @body = params[:message][:body]
    @offer = Offer.find(params[:offer_id])
    notification_email = RequestNotificationEmail.new(current_user, @body, @offer)
    confirmation_email = RequestConfirmationEmail.new(current_user, @body, @offer)
    UserMailer.request_email(notification_email).deliver
    UserMailer.request_email(confirmation_email).deliver
    redirect_back_or @offer, success: "Message sent."
  end
end
