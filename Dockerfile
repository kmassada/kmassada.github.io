FROM ruby:latest
RUN mkdir -p /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN gem install jekyll bundler sass
RUN gem which bundler
RUN bundle --version
RUN bundle install
# RUN bundle exec jekyll serve
CMD ["bundle", "exec", "jekyll", "serve", "-H", "0.0.0.0", "--incremental", "--watch"]