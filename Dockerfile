FROM ruby:2.3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /arma-stats
WORKDIR /arma-stats
ADD Gemfile /arma-stats/Gemfile
ADD Gemfile.lock /arma-stats/Gemfile.lock
RUN bundle install -j4
ADD . /arma-stats
CMD ["rails","server","-b","0.0.0.0"]
