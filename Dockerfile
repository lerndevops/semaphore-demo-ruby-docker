# Dockerfile development version
# Intended to use volumes to map code

FROM ruby:2.7 AS drkiq-development
MAINTAINER SemaphoreCI

# Docker build arguments
ARG USER_ID
ARG GROUP_ID

# Create a user with the same ID and GID
RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

# Default directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# Install Nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn

# Install rails
RUN gem install rails bundler

# Install gems
COPY drkiq/Gemfile Gemfile
WORKDIR /opt/app/drkiq
RUN bundle install

# Start server as user
RUN chown -R user:user /opt/app
USER $USER_ID
VOLUME ["$INSTALL_PATH/public"]
CMD bundle exec unicorn -c config/unicorn.rb

