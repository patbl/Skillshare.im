class UserDecorator < ApplicationDecorator
  delegate_all

  def current_user?
    self == h.current_user
  end

  def profile_link(attribute, logo, public: false)
    return unless h.signed_in? || public
    link = user.public_send(attribute)
    return unless link
    h.content_tag :div, class: "user-profile-link" do
      link_method = attribute == :email ? :mail_to : :link_to
      h.public_send(link_method, link, target: "_blank") do
        h.content_tag :div, class: "btn btn-small btn-default" do
          h.fa_tag(logo)
        end
      end
    end
  end
end
