# frozen_string_literal: true

module Trends
  module Actions
    module Token
      class Update < Trends::Action
        def handle(*, response)
          response.body = self.class.name
        end
      end
    end
  end
end
