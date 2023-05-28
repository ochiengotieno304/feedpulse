FROM ruby:3.1
LABEL authors="ochi"


# Set environment variables
ENV APP_HOME /app
ENV LANG C.UTF-8

# Install system dependencies
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev nodejs

# Set working directory
WORKDIR $APP_HOME

# Install application dependencies
COPY Gemfile Gemfile.lock $APP_HOME/
RUN gem install bundler && \
    bundle install --jobs 4 --retry 3

# Copy application code
COPY . $APP_HOME

# Expose ports
EXPOSE 2300

# Set up PostgreSQL
ENV POSTGRES_HOST=db
ENV POSTGRES_PORT=5432

# Set up Redis
ENV REDIS_HOST=redis
ENV REDIS_PORT=6379

# Set up Sidekiq
ENV SIDEKIQ_CONCURRENCY=5

# Start the application
CMD ["hanami", "server", "--host", "0.0.0.0"]

