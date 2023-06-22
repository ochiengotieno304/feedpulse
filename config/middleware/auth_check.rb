# frozen_string_literal: true

require 'cgi'

class AuthCheck
  def initialize(app)
    @app = app
  end

  def call(env)
    api_key = env.fetch('HTTP_AUTHORIZATION', '')
    proxy_secret = env.fetch('HTTP_X_MASHAPE_PROXY_SECRET', '')

    env[:api_key] = api_key
    env[:proxy_secret] = proxy_secret

    return [401, { 'Content-Type' => 'application/json' }, ['missing API Key 😥']] if api_key.nil?

    status, headers, body = @app.call env
    [status, headers, body]
  end
end
