# frozen_string_literal: true

Hanami.app.register_provider(:auth) do
  prepare do
    require 'jwt'
  end

  start do
    @secret = target["settings"].jwt_secret_key
    class Auth
      def self.token user_id
        JWT.encode payload(user_id), @secret, 'HS256'
      end

      def self.payload user_id
        {
          exp: Time.now.to_i + 4 * 3600,
          iat: Time.now.to_i,
          scopes: ['view_news'],
          user: {
            id: user_id
          }
        }
      end
    end

    auth = Auth.new

    register 'auth', auth
  end
end
