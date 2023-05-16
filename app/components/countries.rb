# frozen_string_literal: true

require 'carmen'

module Trends
  module Components
    class Countries
      include Carmen

      def self.country_codes
        YAML.load_file('data.yaml').map do |country|
          Country.named(country).code
        end
      end
    end
  end
end


