class ProposalDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate_all

  def button
    if guest?
      sign_in_button
    elsif current_user == user
      delete_button + edit_button
    else
      contact_button
    end
  end

  def contact_button
    content_tag :div, class: "btn btn-danger btn-small request-btn" do
      fa_tag("envelope", verb.titleize)
    end
  end

  def sign_in_button
    link_to sign_in_path, class: "btn btn-danger btn-small sign-in-btn" do
      fa_tag("envelope", "Sign in to #{verb}")
    end
  end

  def delete_button
    link_to proposal, method: :delete, class: "btn btn-danger btn-small",
                      data: { confirm: "Are you sure you want to delete this #{noun}?" } do
      fa_tag("times")
    end
  end

  def edit_button
    link_to edit_offer_path(proposal), class: "btn btn-primary btn-small" do
      fa_tag("pencil")
    end
  end
end
