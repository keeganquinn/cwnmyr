FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir -p /srv/rails
WORKDIR /srv/rails
ADD Gemfile /srv/rails/Gemfile
ADD Gemfile.lock /srv/rails/Gemfile.lock
RUN bundle install
ADD . /srv/rails
