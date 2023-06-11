# frozen_string_literal: true
require 'cgi'

class AuthCheck
  def initialize app
    @app = app
  end

  def call(env)
    api_key = env.fetch('HTTP_AUTHORIZATION', '')

    env[:api_key] = api_key

    return [401, { 'Content-Type' => 'text/plain' }, ['Missing API Key 😥']] if api_key.nil?

    status, headers, body = @app.call env
    [status, headers, body]
  end
end
