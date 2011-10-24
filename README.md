= HumbleAuth

HumbleAuth is a simple one-person authentication system based on http basic authentication.

[![Build Status](https://secure.travis-ci.org/fxposter/humble_auth.png)](http://travis-ci.org/fxposter/humble_auth)

== Installation and usage

Add gem to your Gemfile:

  gem 'humble_auth'

Generate config file:

  rails generate humble_auth:install

This will create config/auth.yml, which contains your user credentials (yeah, this system is not database-baked, it's YAML-baked instead).
You can provide different credentials for different environments or turn off authentication for some environments at all (for example, for development env).

After that you can

  before_filter :require_authentication

in any of your controllers, and then this controller (or specific actions) will be protected.

You can check whether user is authenticated using ApplicationController#authenticated? method (it's also available in helpers).
Also, you can "logout" using ApplicationController#reset_authentication.



This project rocks and uses MIT-LICENSE.