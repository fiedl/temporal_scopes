# TemporalScopes [![Build Status](https://travis-ci.org/fiedl/temporal_scopes.svg?branch=master)](https://travis-ci.org/fiedl/temporal_scopes)

Providing temporal scopes for an ActiveRecord model that allow to query by time.

## Usage

TODO

Further [documentation can be found on rubydoc.info](http://rubydoc.info/github/fiedl/temporal_scopes/master/frames).

## Installation

### Installing the Gem

Add the gem to your `Gemfile`:

```ruby
# Gemfile
# ...
gem 'temporal_scopes'
```

Then, run `bundle install`.

### Database

Add the columns `valid_from` and `valid_to` to the model you would like to have temporal scopes.

```
bundle exec rails generate migration add_validity_period_to_articles valid_from:datetime:index valid_to:datetime:index
bundle exec rake db:migrate
```

## Author and License

Copyright (c) 2014 Sebastian Fiedlschuster.

Released under the [MIT License](MIT-LICENSE).
