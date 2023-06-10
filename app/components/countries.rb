# frozen_string_literal: true

require 'countries'

module Trends
  module Components
    class Countries
      def self.country_codes
        YAML.load_file('data.yaml').map do |country|
          ISO3166::Country.find_country_by_any_name(country).alpha2
        end
      end
    end
  end
end


