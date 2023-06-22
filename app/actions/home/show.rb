# frozen_string_literal: true

module Trends
  module Actions
    module Home
      class Show < Trends::Action
        def handle(*, response)
          response.body = 'Trends'
        end
      end
    end
  end
end
