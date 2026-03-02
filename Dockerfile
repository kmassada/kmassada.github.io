# Stage 1: Base image with Ruby and dependencies
FROM debian:latest AS dep
RUN apt-get update -qq

# Update the package index and install necessary packages
RUN apt-get update && apt-get install -y \
    ruby \
    ruby-bundler \
    ruby-dev \
    build-essential \
    locales \
    git \
 && rm -rf /var/lib/apt/lists/*

# Language locales
RUN locale-gen en_US.UTF-8
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Set the working directory to /app
RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app

# Jekyll setup
RUN gem install jekyll bundler

# Jekyll setup
CMD ["ruby","--version"]

# Stage 2: Application setup
FROM kmassada.github.io.dep:latest AS app

# Work dir
RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app

# Verify installations
RUN gem which bundler
RUN bundle --version
RUN which ruby
RUN ruby --version

RUN bundle install
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0", "--incremental", "--watch"]