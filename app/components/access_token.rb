# frozen_string_literal: true

require 'securerandom'

module Trends
  module Components
    # Generate client_id and client_secret
    class AccessToken
      attr_reader :client_id, :client_secret

      def initialize
        @client_id = SecureRandom.hex
        @client_secret = SecureRandom.hex
      end

      def inspect
        '#<Trends::Components::OauthToken>'
      end
    end
  end
end
