class UserDecorator < ApplicationDecorator
  delegate_all

  def current_user?
    self == h.current_user
  end

  def facebook_link
    return unless h.signed_in? && (link = user.facebook_url)

    h.content_tag :div, class: "user-profile-link" do
      h.link_to link, target: "_blank" do
        h.content_tag :div, class: "btn btn-small btn-default" do
          h.fa_tag("facebook", tooltip: "Facebook")
        end
      end
    end
  end

  def email_link
    return unless h.signed_in? && (link = user.email)

    h.content_tag :div, class: "user-profile-link" do
      h.mail_to link, target: "_blank" do
        h.content_tag :div, class: "btn btn-small btn-default" do
          h.fa_tag("envelope", tooltip: "E-mail")
        end
      end
    end
  end

  def ea_hub_profile_link
    return unless (link = user.ea_profile)

    h.content_tag :div, class: "user-profile-link" do
      h.link_to "EA Hub", link, target: "_blank", class: "ea-hub-profile-link"
    end
  end
end
