class MessagesController < ApplicationController
  include ApplicationHelper # for Markdown

  def create
    @body = params[:message][:body]
    @offer = Offer.find(params[:offer_id])
    UserMailer.request_confirmation(current_user, @body, @offer).deliver
    UserMailer.request_notification(current_user, @body, @offer).deliver
    redirect_back_or @offer, success: "Message sent."
  end
end
