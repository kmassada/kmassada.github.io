FROM debian:latest
# Work dir
RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app
# packages
RUN apt-get update -qq
RUN apt-get install -qy  git rubygems ruby-dev linux-headers-* build-essential  zlib1g-dev locales autoconf libltdl-dev libtool
# Language locales
RUN locale-gen en_US.UTF-8
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
# Jekyll setup
RUN gem install jekyll bundler sass
RUN gem which bundler
RUN bundle --version
RUN bundle install
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0", "--incremental", "--watch"]