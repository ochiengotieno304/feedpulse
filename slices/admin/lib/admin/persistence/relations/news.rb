# frozen_string_literal: true

module Admin
  module Persistence
    module Relations
      class News < ROM::Relation[:sql]
        schema(:news, infer: true)
      end
    end
  end
end
