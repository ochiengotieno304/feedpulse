FROM ruby:3.1.4-alpine

RUN apk add build-base postgresql libpq-dev curl

COPY . /app/

WORKDIR /app

RUN bundle install

RUN chmod +x entry.sh

ENTRYPOINT ["/app/entry.sh"]

CMD ["hanami", "server"]
