# frozen_string_literal: true

source 'https://rubygems.org'

gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-router', '~> 2.2'
gem 'hanami-validations', '~> 2.0'

gem 'dry-types'
gem 'puma'
gem 'rake'

gem 'pg'
gem 'rom', '~> 5.3'
gem 'rom-sql', '~> 3.6'

gem 'activesupport', '~> 7.2'
gem 'bcrypt', '~> 3.1'
gem 'classifier-reborn'
gem 'countries', '~> 5.4'
gem 'feedjira', '~> 3.2', '>= 3.2.2'
gem 'foreman'
gem 'httparty', '~> 0.21.0'
gem 'jwt', '~> 2.7'
gem 'logger', '~> 1.7'
gem 'rack-cors'
gem 'rack-heartbeat'
gem 'rack-oauth2'
gem 'redis', '~> 5.0'
gem 'sidekiq', '~> 7.3'
gem 'sidekiq-scheduler', '~> 5.0'
gem 'tzinfo-data'

group :development, :test do
  gem 'dotenv'
  gem 'rubocop', require: false
end

group :cli, :development do
  gem 'hanami-reloader'
end

group :cli, :development, :test do
  gem 'hanami-rspec'
end

group :development do
  gem 'guard-puma', '~> 0.8'
end

group :test do
  gem 'database_cleaner-sequel'
  gem 'rack-test'
end
