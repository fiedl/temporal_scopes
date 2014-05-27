# TemporalScopes [![Build Status](https://travis-ci.org/fiedl/temporal_scopes.svg?branch=master)](https://travis-ci.org/fiedl/temporal_scopes)

Providing temporal scopes for an ActiveRecord model to allow queries by time. For example, `MyModel.now.where(...)`, `my_model.archive`, `MyModel.past.where(...)`.

This is done by adding the database columns `valid_from` and `valid_to` to the model's table.

## Usage

TODO

### Documentation

Further [documentation can be found on rubydoc.info](http://rubydoc.info/github/fiedl/temporal_scopes/master/frames).

### Caveats

* There is only one `valid_from` and one `valid_to` time per object. Therefore, you can't keep track of first archiving an object and later un-archiving it. Un-archiving an object loses the information of first archiving it.

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
