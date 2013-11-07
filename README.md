# EA Skillshare

EA Skillshare is a Rails app whose purpose is to make it easier for
effective altruists to help each other out by sharing their skills,
stuff, and even couches with one another.

## Contributing

This is my first real Rails app, so any help would be gratefully
received.

### Setup

Getting the environment variables set, gems configured, and packages
installed was a huge headache for me, so if you need any help, please
ask! We can arrange a Skype chat if you think it would be helpful.

Here's what I can remember off the top of my head:

* EA Skillshare uses Ruby 2.0. You should probably use a Ruby
  environment manager, such as RVM or rbenv.

* EA Skillshare uses Facebook for authentication. I've created two
  Facebook apps: one for development and testing (which can
  communicate with localhost:3000), and one for production (which can
  communicate with http://ea-skillshare.herokuapp.com). Perhaps it's
  possible to use a single app, but I haven't been able to figure out
  how to do so. To get Facebook authentication working, you'll need to
  set a couple of environment variables. I used the Figaro gem (here's
  a
  [good tutorial](http://railsapps.github.io/rails-environment-variables.html)).
  If you message me and you seem legit, I'll send you the API keys and
  secrets that I'm using. Alternatively, you can set up your own
  Facebook app, but it would be better for us to be working off the
  same one.

* EA Skillshare uses
  [Capybara Webkit](https://github.com/thoughtbot/capybara-webkit) for
  JavaScript testing. Or I would be, if I could get
  [Database Cleaner](https://github.com/bmabey/database_cleaner)
  configured properly. Capybara Webkit requires some system-specific
  set up; refer to
  [this page](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit)
  for instructions.

* I'm using the GitHub issues tracker. The issues that I think I can
  fix by myself are assigned to me. I'd be grateful for help on the
  issues that aren't assigned. If you want to use some other
  collaboration or tracking tool, let me know. Since I've been the
  only one working on it so far, I haven't needed anything else.

### Roadmap

1. Make EA Skillshare an awesome app that people love to use and that
   makes the world a better place!
