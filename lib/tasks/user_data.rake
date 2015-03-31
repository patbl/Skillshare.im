namespace :user_data do
  desc "This task generates a list of user information for use by Tom Ash"
  task generate_user_profile_urls: :environment do
    include ActionView::Helpers::UrlHelper
    User.find_each do |user|
      url = Rails.application.routes.url_helpers.user_url(user, host: "http://skillshare.im")
      name = user.full_name
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

  desc "Print a digest of the last x offers."
  task :digest, [:count] =>  :environment do |task, args|
    count = args[:count].try(:to_i) || 20
    proposals = Proposal
               .order(created_at: :desc)
               .limit(count)
               .group_by { |proposal| proposal.type }
    print_digest_data(proposals["Wanted"])
    print_digest_data(proposals["Offer"])
  end

  def print_digest_data(proposals)
    puts "\n#{proposals.first.type}s\n\n"
    proposals.each do |proposal|
      puts proposal.title
      puts Rails.application.routes.url_helpers.send("#{proposal.type.downcase}_url".to_sym, proposal)
      puts
    end
  end
end
