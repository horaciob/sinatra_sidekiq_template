FROM ruby:3.3.0-alpine

WORKDIR /app

RUN apk --update add build-base tzdata postgresql-dev postgresql-client libxslt-dev libxml2-dev

COPY Gemfile Gemfile.lock /app/

RUN apk --no-cache add build-base \
  && gem install bundler --without development test \
  && bundle install

COPY . /app/

EXPOSE 3000

# Command to run your Sinatra application
CMD ["bundle", "exec", "rake", "db:migrate"]
#"&&", "bundle", "exec", "rake", "db:migrate", "&&", "bundle", "exec", "puma", "-p" ,"3000"]
