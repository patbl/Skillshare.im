[![Build Status](https://travis-ci.org/patbl/Skillshare.im.png?branch=master)](https://travis-ci.org/patbl/Skillshare.im)
[![Code Climate](https://codeclimate.com/github/patbl/Skillshare.im.png)](https://codeclimate.com/github/patbl/Skillshare.im)
[![Coverage Status](https://coveralls.io/repos/patbl/Skillshare.im/badge.png?branch=master)](https://coveralls.io/r/patbl/Skillshare.im?branch=master)
[![Dependency Status](https://gemnasium.com/patbl/Skillshare.im.png)](https://gemnasium.com/patbl/Skillshare.im)

# Skillshare.im

Skillshare.im is a Rails app whose purpose is to make it easier for
effective altruists to help each other out by sharing their skills,
stuff, and even couches with one another.

## Contributing

Check out the [Trello board](https://trello.com/b/3ULaf1Ob/sharing-app)
to see what we're working on. If you'd like to help, let us know!

Getting the environment variables set, gems configured, and packages
installed was a huge headache, so if you need any help, please ask! We
can arrange a Skype chat if it would be helpful.

Here are some important points:

* EA Skillshare uses Ruby 2.0. You should probably use a Ruby environment manager, such as RVM or rbenv.

* EA Skillshare uses Facebook for authentication. I've created two Facebook apps: one for development and testing (which can communicate with localhost:3000), and one for production (which can communicate with http://skillshare.im). Perhaps it's possible to use a single app, but I haven't been able to figure out how to do so. To get Facebook authentication working, you'll need to set a couple of environment variables. I used the Figaro gem (here's a [good tutorial](http://railsapps.github.io/rails-environment-variables.html)). If you message me and you seem legit, I'll send you the API keys and secrets that I'm using. Alternatively, you can set up your own Facebook app, but it would be better for us to be working off the same one.

* The feature specs are annoying because they keep breaking, so I tagged most of them with `skip`. Then there's the `slow` tag, which is applied most of the feature specs. This keeps them from running by default. If you want them to run, use `rspec -t slow`. Or if you want them to run by default, add `SLOW_SPECS: true` to your `application.yml` file.
