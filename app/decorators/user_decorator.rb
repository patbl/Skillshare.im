class UserDecorator < ApplicationDecorator
  delegate_all

  def current_user?
    self == h.current_user
  end

  def profile_link(attribute, logo)
    link = user.public_send(attribute)
    return unless link
    h.content_tag :div, class: "user-profile-link" do
      h.link_to link do
        h.content_tag :div, class: "btn btn-small btn-default" do
          h.fa_tag(logo)
        end
      end
    end
  end
end
