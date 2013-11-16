[![Build Status](https://travis-ci.org/patbl/ea-skillshare.png?branch=master)](https://travis-ci.org/patbl/ea-skillshare)
[![Code Climate](https://codeclimate.com/github/patbl/ea-skillshare.png)](https://codeclimate.com/github/patbl/ea-skillshare)
[![Coverage Status](https://coveralls.io/repos/patbl/ea-skillshare/badge.png?branch=master)](https://coveralls.io/r/patbl/ea-skillshare?branch=master)
[![Dependency Status](https://gemnasium.com/patbl/ea-skillshare.png)](https://gemnasium.com/patbl/ea-skillshare)

# EA Skillshare

EA Skillshare is a Rails app whose purpose is to make it easier for
effective altruists to help each other out by sharing their skills,
stuff, and even couches with one another.

## Contributing

This is my first real Rails app, so any help would be gratefully
received. If you want to see what's being worked on, check out the
[Trello board](https://trello.com/b/3ULaf1Ob/sharing-app).

Getting the environment variables set, gems configured, and packages
installed was a huge headache, so if you need any help, please ask! We
can arrange a Skype chat if you think it would be helpful.

Here's what I can remember off the top of my head:

* EA Skillshare uses Ruby 2.0. You should probably use a Ruby
  environment manager, such as RVM or rbenv.

* EA Skillshare uses Facebook for authentication. I've created two
  Facebook apps: one for development and testing (which can
  communicate with localhost:3000), and one for production (which can
  communicate with http://skillshare.im). Perhaps it's
  possible to use a single app, but I haven't been able to figure out
  how to do so. To get Facebook authentication working, you'll need to
  set a couple of environment variables. I used the Figaro gem (here's a
  [good tutorial](http://railsapps.github.io/rails-environment-variables.html)).
  If you message me and you seem legit, I'll send you the API keys and
  secrets that I'm using. Alternatively, you can set up your own
  Facebook app, but it would be better for us to be working off the
  same one.

* If you're deploying to Heroku, make sure to run
  `RAILS_ENV=production bundle exec rake assets:precompile` before stage your
  changes.

* If you or someone else has edited a previous migration, you'll need
  to run `rake db:migrate:reset` (instead of the regular `rake
  db:migrate`) locally. When you deploy to Heroku, you'll need to run

    heroku pg:reset DATABASE_URL --confirm ea-skillshare
    heroku run rake db:migrate
