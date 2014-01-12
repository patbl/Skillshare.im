class MessagesController < ApplicationController
  include ApplicationHelper # for Markdown

  def create
    @body = params[:message][:body]
    @offer = Offer.find(params[:offer_id])
    UserMailer.request_email(current_user, @body, @offer, notification: false).deliver
    UserMailer.request_email(current_user, @body, @offer).deliver
    redirect_back_or @offer, success: "Message sent."
  end
end
