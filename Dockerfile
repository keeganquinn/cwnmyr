FROM ruby:2.6.1
MAINTAINER Keegan Quinn <keeganquinn@gmail.com>

# Install supplemental Debian main packages
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    bison build-essential graphviz libgdbm-dev postgresql-client \
  && apt-get clean

# Add node and yarn sources, install additional packages
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    nodejs yarn \
  && apt-get clean

# Install phantomjs
RUN export PHANTOMJS="phantomjs-2.1.1-linux-x86_64" \
  && mkdir /tmp/phantomjs \
  && curl -L https://bitbucket.org/ariya/phantomjs/downloads/${PHANTOMJS}.tar.bz2 \
  | tar -xj --strip-components=1 -C /tmp/phantomjs \
  && mv /tmp/phantomjs/bin/phantomjs /usr/local/bin \
  && rm -rf /tmp/phantomjs

# Update to Bundler 2
RUN gem install bundler

# Add application dependencies
WORKDIR /srv/app

COPY Gemfile /srv/app/Gemfile
COPY Gemfile.lock /srv/app/Gemfile.lock
RUN bundle install

COPY package.json /srv/app/package.json
COPY yarn.lock /srv/app/yarn.lock
RUN yarn install
