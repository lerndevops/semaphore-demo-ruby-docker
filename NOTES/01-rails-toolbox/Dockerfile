FROM ruby:2.7 AS rails-toolbox
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

# Install rails
# RUN apt-get update && apt-get install --no-install-recommends -y rails bundler
RUN gem install rails bundler
RUN chown user:user /opt/app
WORKDIR /opt/app

# Run a shell as the user
USER $USER_ID
CMD ["/bin/sh"]
