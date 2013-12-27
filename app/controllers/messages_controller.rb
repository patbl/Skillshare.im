class MessagesController < ApplicationController
  include ApplicationHelper # for Markdown

  before_action :ensure_signed_in

  def create
    @body = params[:message][:body]
    @offer = Offer.find(params[:offer_id])
    UserMailer.request_mail(current_user, @body, @offer).deliver
    UserMailer.request_confirmation(current_user, @body, @offer).deliver
    redirect_back_or @offer, success: "Message sent."
  end
end
