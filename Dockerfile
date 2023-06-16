FROM ruby:3.1.2-alpine
RUN apk add build-base postgresql libpq-dev curl
COPY . /app/
WORKDIR /app
RUN bundle install