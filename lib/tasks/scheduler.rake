desc "This task is called by the Heroku scheduler add-on"
task send_emails: :environment do
  Subscription.send_emails
end
