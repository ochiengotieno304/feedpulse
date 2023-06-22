# frozen_string_literal: true

module Trends
  module Persistence
    module Relations
      class News < ROM::Relation[:sql]
        schema(:news, infer: true)

        use :pagination
        per_page 10
      end
    end
  end
end
