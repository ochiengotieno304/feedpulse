# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-scheduler'
require 'hanami/boot'
require 'active_support'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end
