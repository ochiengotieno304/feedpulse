require 'sidekiq'
require 'sidekiq-scheduler'
require 'hanami/boot'
require 'active_support'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379' } # Redis connection URL
  config.average_scheduled_poll_interval = 5 # Polling interval for scheduled jobs
  config.error_handlers << proc { |ex, ctx_hash| MyErrorService.notify(ex, ctx_hash) } # Error handling
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379' } # Redis connection URL
end

Sidekiq.default_job_options = {
  backtrace: true, # Include backtrace in job error reports
  retry: 5 # Number of times to retry a failed job
}

Sidekiq.logger.level = Logger::INFO
