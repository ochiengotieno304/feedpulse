FROM ruby:3.1.4-alpine

RUN apk add --no-cache build-base curl libpq-dev postgresql

COPY . /app/

WORKDIR /app

RUN bundle install

CMD ["foreman", "start", "-f", "Procfile"]
