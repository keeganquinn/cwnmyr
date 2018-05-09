FROM debian:stable
MAINTAINER Keegan Quinn <keeganquinn@gmail.com>

# Install Debian main packages
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends \
    autoconf bison build-essential ca-certificates curl \
    file git gnupg graphviz imagemagick \
    libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev \
    libffi-dev libgdbm-dev libpq-dev libmagickwand-dev \
    postgresql-client \
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

# Install rbenv, ruby-build, build a Ruby
RUN git clone https://github.com/rbenv/rbenv.git /root/.rbenv
RUN cd /root/.rbenv && git pull && \
  git reset --hard c8ba27fd07e4bf3c444df301e5fb2a5fcdacaf9d
RUN git clone \
  https://github.com/rbenv/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN /root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> .bashrc
RUN rbenv install -s 2.5.1 \
  && rbenv global 2.5.1 \
  && gem install bundler

# Configure bundler to install gems out of tree
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
  BUNDLE_BIN="$GEM_HOME/bin" \
  BUNDLE_SILENCE_ROOT_WARNING=1 \
  BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
  && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

# Add application dependencies
WORKDIR /srv/rails

COPY Gemfile /srv/rails/Gemfile
COPY Gemfile.lock /srv/rails/Gemfile.lock
RUN bundle install

COPY package.json /srv/rails/package.json
COPY yarn.lock /srv/rails/yarn.lock
RUN yarn install
