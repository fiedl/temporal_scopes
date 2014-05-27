# TemporalScopes [![Build Status](https://travis-ci.org/fiedl/temporal_scopes.svg?branch=master)](https://travis-ci.org/fiedl/temporal_scopes)

Providing temporal scopes for an ActiveRecord model to allow queries by time. For example, `MyModel.now.where(...)`, `my_model.archive`, `MyModel.past.where(...)`.

This is done by adding the database columns `valid_from` and `valid_to` to the model's table.

## Usage

### Make an `ActiveRecord` have temporal scopes

```ruby
class Article < ActiveRecord::Base
  has_temporal_scopes
  
end
```

### Archive an object

```ruby
current_article = Article.create(title: 'My new article', body: 'Lorem ipsum')

past_article = Article.create(title: 'My new article', body: 'Lorem ipsum')
past_article.archive

# or provide a datetime:
past_article.archive at: 1.hour.ago
```

### Use temporal scopes for filtering

```ruby
Article.now                          #  => [current_article]
Article.past                         #  => [past_article]
Article.with_past                    #  => [current_article, past_article]
```

Note that the **default scope** is set to `now`.

```ruby
Article.all                          #  => [current_article]
Article.now                          #  => [current_article]
Article.with_past                    #  => [current_article, past_article]
Article.without_temporal_condition   #  => [current_article, past_article]
```

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
