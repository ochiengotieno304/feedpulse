# frozen_string_literal: true

require 'hanami'
require_relative 'middleware/jwt_auth'


module Trends
  class App < Hanami::App
    config.middleware.use :body_parser, :json
    # config.middleware.use JwtAuth
    # environment(:development) do
    #   config.logger.stream = root.join('log').join('development.log')
    #   config.logger.filters = config.logger.filters + %w[token access_token refresh_token]
    #   config.logger.options[:colorize] = true
    #   config.logger.formatter = :json
    # end
  end
end
