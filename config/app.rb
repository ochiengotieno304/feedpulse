# frozen_string_literal: true

require "hanami"
require_relative 'middleware/jwt_auth'


module Trends
  class App < Hanami::App
    config.middleware.use :body_parser, :json
    # config.middleware.use JwtAuth
  end
end
