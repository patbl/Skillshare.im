class OfferDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def button
    if guest?
      link_to facebook_auth_path, class: "btn btn-danger btn-small" do
        fa_tag("envelope", "Sign in to request")
      end
    elsif current_user == user
      (link_to offer, method: :delete, class: "btn btn-danger btn-small",
        data: { confirm: "Are you sure you want to delete this offer?" } do
          fa_tag("times")
        end) +
        (link_to edit_offer_path(offer), class: "btn btn-primary btn-small" do
          fa_tag("pencil")
        end)
    else
      content_tag :div, class: "btn btn-danger btn-small request-btn" do
        fa_tag("envelope", "Request")
      end
    end
  end
end
