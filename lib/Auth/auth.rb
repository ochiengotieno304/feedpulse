# frozen_string_literal: true
module Auth
  class Auth
    attr_reader :secret

    def initialize secret
      @secret = secret
    end

    def self.token user_id
      # JWT.encode payload(user_id), @secret, 'HS256'
      access_token = JWT.encode(payload(user_id), @secret, 'HS256')
      refresh_token = refresh_token(user_id)
      { access_token: access_token, refresh_token: refresh_token }
    end

    def self.payload user_id
      {
        exp: Time.now.to_i + 3600,
        iat: Time.now.to_i,
        iss: 'https://feedpulse.live',
        scopes: ['view_news'],
        user: {
          id: user_id
        }
      }
    end

    def self.refresh_token(user_id)
      JWT.encode(refresh_payload(user_id), @secret, 'HS256')
    end

    def self.refresh_payload(user_id)
      {
        exp: Time.now.to_i + 7 * 24 * 3600,
        iat: Time.now.to_i,
        iss: 'https://feedpulse.live',
        user: {
          id: user_id
        }
      }
    end
  end
end

