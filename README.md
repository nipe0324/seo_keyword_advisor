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

* Access pages by browser

http://localhost:3000/

## Production

* set ENV as below

- RAILS_ROOT (required) - Rails root path
- HTTP_BASIC_NAME (required) - HTTP basic auth name
- HTTP_BASIC_PASSWORD (required) - HTTP basic auth password
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
