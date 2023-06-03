# frozen_string_literal: true

# require 'json'

# Middleware that ensures all requests are in JSON format
class JsonFilterMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    unless request.content_type == 'application/json'
      return [400, { 'Content-Type' => 'application/json' }, ['Bad Request: Only JSON requests are allowed']]
    end


    begin
      JSON.parse(request.body.read)
    rescue JSON::ParserError
      return [400, { 'Content-Type' => 'application/json' }, ['Bad Request: Invalid JSON']]
    end

    request.body.rewind
    @app.call env
  end
end
