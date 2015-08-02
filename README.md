# SEO keyword advisor

For selecting SEO keywords for your media site to list up google search results.

# How to use

1. Input keywords you want to list up Google search results (it's extracted from Google keyword planner or something). And, submit "Analyze".

2. You can see some analysis for SEO after little after or after a little while.

##  Now abalable analysis info

* Occurrences of domain name to discover which sites competitor is.


# Environment

## Development

### Setup

Recoomend to use `ruby 2.2.1`


* DB Migration to Postgres

```
# confirm postgresql is running
psql -l
                     List of databases
       Name       |  Owner   | Encoding |   Collate   |
------------------+----------+----------+-------------+-
 postgres         | postgres | UTF8     | ja_JP.UTF-8 |
 template0        | postgres | UTF8     | ja_JP.UTF-8 |
 template1        | postgres | UTF8     | ja_JP.UTF-8 |


# migration
bundle exec rake db:create
bundle exec rake db:migrate

# seed data
bundle exec rake db:seed
```

* Run process

```
bundle exec foreman start -f Procfile.development
```

* Access pages by browser

http://localhost:3000/

## Production

* set ENV as below

- RAILS_ROOT (required) - Rails root path
- HTTP_BASIC_NAME (required) - HTTP basic auth name
- HTTP_BASIC_PASSWORD (required) - HTTP basic auth password
- SECRET_KEY_BASE (required) - secret key (such as `rake secret`)
- WEB_CONCURRENCY (optional. default 3) - unicorn workers

* Start unicorn

```
# start unicron
RAILS_ENV=production bundle exec rake unicorn:start

# confirm wheter unicorn run or not
ps -ef | grep unicorn | grep -v grep

# stop unicorn
RAILS_ENV=production bundle exec rake unicorn:start
```

## Heroku

For free usage, don't use resque.
Foreground scraiping process.


## With background job on Resque

For running on Heroku free plan, I don't use resque for scriping.

* Remove comment out and comment out

```
class KeywordSetsController < ApplicationController

  def create
    ...

    if @keyword_set.save
      ### remove comment out here if use resque. ###
      # For heroku free usage, don't use resque
      # ScrapeSearchResultsJob.perform_later(@keyword_set)
      ### And comment out @keyword_set.scrape.   ###
      @keyword_set.scrape
      redirect_to keyword_sets_url, notice: '入力したキーワードで分析を開始しました。少々お待ち下さい。'
    else
      render :new
    end

    def update
      @keyword_set = KeywordSet.find(params[:id])
      ### remove comment out here if use resque. ###
      # For heroku free usage, don't use resque
      # ScrapeSearchResultsJob.perform_later(@keyword_set)
      # @keyword_set.working!
      ### And comment out @keyword_set.scrape.   ###
      @keyword_set.scrape
      redirect_to keyword_sets_url, notice: '再度分析を開始しました。少々お待ち下さい。'
    end
  end
  ...
end
```

* Run Redis

```
# install redis to mac os if you don't install it
brew install redis

# run redis
redis-server
```

* Run resque worker

```
bundle exec rake resque:work
```

* Run Rails on Webrick

```
bundle exec rails s
```
