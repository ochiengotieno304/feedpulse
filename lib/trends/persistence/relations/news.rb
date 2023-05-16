module Trends
  module Persistence
    module Relations
      class News < ROM::Relation[:sql]
        schema(:news, infer: true)

        use :pagination
        per_page 5
      end
    end
  end
end