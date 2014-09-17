desc "This task generates a list of user information for use by Tom Ash"
task generate_user_profile_urls: :environment do
  include ActionView::Helpers::UrlHelper
  User.find_each do |user|
    url = Rails.application.routes.url_helpers.user_url(user, host: "http://skillshare.im")
    name = user.name
    email = user.email
    puts [name, email, url].join(";")
  end
end
