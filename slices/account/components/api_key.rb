# frozen_string_literal: true

require 'securerandom'
require 'bcrypt'

module Account
  module Components
    # Generate client_id and client_secret
    class APIKey
      include BCrypt
      attr_reader :api_key, :api_key_encrypted

      def initialize
        @api_key = SecureRandom.hex
        @api_key_encrypted = BCrypt::Password.create(api_key)
      end

      def inspect
        '#<Trends::Components::APIKey>'
      end

      def test_keys
        api_key_encrypted == api_key
      end
    end
  end
end
