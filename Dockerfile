ARG RUBY_VERSION=2.6

FROM ruby:$RUBY_VERSION

# Setup the lib directory
ENV LIB_DIR /yahoo-fantasy-ruby
RUN mkdir $LIB_DIR
WORKDIR $LIB_DIR

# Setup Bundler
ADD Gemfile* $LIB_DIR/
ADD yahoo_fantasy.gemspec $LIB_DIR/

run bundle install

ADD . $LIB_DIR