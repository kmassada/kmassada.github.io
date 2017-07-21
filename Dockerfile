FROM ruby:latest
RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN gem install jekyll bundler
RUN gem which bundler
RUN bundle --version
# RUN bundle exec jekyll serve
# CMD ["bundle", "exec", "jekyll", "serve"]