class OfferDecorator < Draper::Decorator
  delegate_all

  def button
    # FIXME
    if h.current_user && h.current_user != user
      h.content_tag :div, class: "btn btn-danger btn-small request-btn" do
        %(<i class="fa fa-envelope"></i> Request).html_safe
      end
    elsif h.current_user == user
      (h.link_to offer, method: :delete, class: "btn btn-danger btn-small delete-offer-btn",
                             data: { confirm: "Are you sure you want to delete this offer?" } do
        '<i class="fa fa-times"></i>'.html_safe
      end) +
      (h.link_to h.edit_offer_path(offer), class: "btn btn-primary btn-small edit-offer-btn" do
        '<i class="fa fa-pencil"></i>'.html_safe
      end)
    else
      h.link_to h.facebook_auth_path, class: "btn btn-danger btn-small" do
        %(<i class="fa fa-envelope"></i> Sign in to request).html_safe
      end
    end
  end
end
