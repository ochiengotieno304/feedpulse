# frozen_string_literal: true

require 'hanami'
require 'rack/cors'
require_relative 'middleware/jwt_auth'
require_relative 'middleware/json_filter_middleware'
require_relative 'sidekiq'

module Trends
  class App < Hanami::App
    config.actions.format :json
    config.middleware.use :body_parser, :json
    # config.middleware.use JsonFilterMiddleware
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post options patch delete]
      end
    end
  end
end
