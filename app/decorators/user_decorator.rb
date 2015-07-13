class UserDecorator < ApplicationDecorator
  delegate_all

  def current_user?
    self == h.current_user
  end

  def facebook_link
    return unless h.signed_in? && user.facebook_url.present?

    h.content_tag :div, class: "user-profile-link" do
      h.link_to user.facebook_url, target: "_blank" do
        h.content_tag :div, class: "btn btn-small btn-default" do
          h.fa_tag("facebook", tooltip: "Facebook")
        end
      end
    end
  end

  def email_link
    return unless h.signed_in? && user.email.present?

    h.content_tag :div, class: "user-profile-link" do
      h.mail_to user.email, target: "_blank" do
        h.content_tag :div, class: "btn btn-small btn-default" do
          h.fa_tag("envelope", tooltip: "E-mail")
        end
      end
    end
  end

  def fancy_ea_hub_profile_link
    return unless ea_hub_profile_link

    h.content_tag :div, class: "user-profile-link" do
      ea_hub_profile_link(klass: "ea-hub-profile-link")
    end
  end

  def ea_hub_profile_link(klass: "")
    return unless user.ea_profile.present?

    h.link_to "EA Profile", user.ea_profile, target: "_blank", class: klass
  end

  def proposal_user_profile_link
    if ea_hub_profile_link
      "#{internal_profile_link} (#{ea_hub_profile_link})".html_safe
    else
      internal_profile_link
    end
  end

  def internal_profile_link
    h.link_to full_name, self
  end
end
