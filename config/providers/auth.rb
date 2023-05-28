# frozen_string_literal: true

Hanami.app.register_provider(:auth) do
  prepare do
    require 'jwt'
    require "Auth/auth"
  end

  start do

    auth = Auth::Auth.new(target["settings"].jwt_secret_key)

    register 'auth', auth
  end
end
