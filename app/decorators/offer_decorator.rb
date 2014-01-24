class OfferDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate_all

  def button
    if guest?
      sign_in_button
    elsif current_user == user
      delete_button + edit_button
    else
      request_button
    end
  end

  def request_button
    content_tag :div, class: "btn btn-danger btn-small request-btn" do
      fa_tag("envelope", "Request")
    end
  end

  def sign_in_button
    link_to facebook_auth_path, class: "btn btn-danger btn-small" do
      fa_tag("envelope", "Sign in to request")
    end
  end

  def delete_button
    link_to offer, method: :delete, class: "btn btn-danger btn-small",
    data: { confirm: "Are you sure you want to delete this offer?" } do
      fa_tag("times")
    end
  end

  def edit_button
    link_to edit_offer_path(offer), class: "btn btn-primary btn-small" do
      fa_tag("pencil")
    end
  end
end
