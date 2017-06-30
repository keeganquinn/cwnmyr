FROM ruby:2.3.3
MAINTAINER Keegan Quinn <keeganquinn@gmail.com>

# Install Debian packages
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    build-essential graphviz libpq-dev nodejs \
  && apt-get clean

# Install phantomjs
RUN export PHANTOMJS="phantomjs-2.1.1-linux-x86_64" \
  && mkdir /tmp/phantomjs \
  && curl -L https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOMJS}.tar.bz2 \
  | tar -xj --strip-components=1 -C /tmp/phantomjs \
  && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin \
  && rm -rf /tmp/phantomjs

# Set up user and path
RUN useradd -m app && mkdir -p /srv/rails && chown app:app /srv/rails
USER app
WORKDIR /srv/rails

# Add application
ADD Gemfile /srv/rails/Gemfile
ADD Gemfile.lock /srv/rails/Gemfile.lock
RUN bundle install
ADD . /srv/rails
