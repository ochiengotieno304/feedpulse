# frozen_string_literal: true

require 'hanami'
require 'rack/cors'
require 'rack/heartbeat'
require_relative 'middleware/auth_check'

module Trends
  class App < Hanami::App
    config.middleware.use :body_parser, :json
    # config.middleware.use AuthCheck
    config.middleware.use Rack::Heartbeat
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post options patch delete]
      end
    end
  end
end
