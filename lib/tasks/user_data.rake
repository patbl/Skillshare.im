namespace :user_data do
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

  desc "Add EA profile URLs to users with matching e-mail addresses."
  task import_ea_profile_urls: :environment do
    while line = STDIN.gets
      CSV.parse(line) do |skillshare_name, email, skillshare_url, ea_hub_url, ea_hub_name|
        user = User.find_by(email: email)
        if user && user.ea_profile.blank?
          user.update ea_profile: ea_hub_url
        end
      end
    end
  end
end
