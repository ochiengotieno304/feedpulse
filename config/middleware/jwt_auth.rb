# frozen_string_literal: true

class JwtAuth
  def initialize app
    @app = app
  end

  def call(env)
    options = { alg: 'HS256' } # TODO: Add issuer
    bearer_token = env.fetch('HTTP_AUTHORIZATION', '').slice(7..-1)
    payload = JWT.decode bearer_token, ENV['JWT_SECRET_KEY'], true, options

    env[:scopes] = payload[0]['scopes']
    env[:user] = payload[0]['user']

    @app.call env

  rescue JWT::ExpiredSignature
    [403, { 'Content-Type' => 'text/plain' }, ['token has expired.']]
  rescue JWT::InvalidIssuerError
    [403, { 'Content-Type' => 'text/plain' }, ['token does not have a valid issuer.']]
  rescue JWT::InvalidIatError
    [403, { 'Content-Type' => 'text/plain' }, ['token does not have a valid "issued at" time.']]
  rescue JWT::DecodeError
    [401, { 'Content-Type' => 'text/plain' }, ['missing or invalid auth token.']]
  end
end
