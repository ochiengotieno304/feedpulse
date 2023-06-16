FROM ruby:3.1.2
RUN apt-get update
RUN apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev
COPY . /api

## Download the root certificate file
#RUN curl -o /root/.postgresql/root.crt --create-dirs 'https://cockroachlabs.cloud/clusters/6db9c595-5fb8-4ab6-bddd-3cd618b576c2/cert'
#
#RUN gem install pg -v '1.5.3' --source 'https://rubygems.org/'
#RUN bundle install
#
#FROM ruby:3.0.1-alpine as runner
#RUN apk add postgresql-libs # Add PostgreSQL runtime libraries
#WORKDIR /app
#COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
#COPY . .
#EXPOSE 2300
#CMD ["bundle", "exec", "hanami", "server", "--host", "0.0.0.0"]
