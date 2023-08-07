# frozen_string_literal: true

module Admin
  module Actions
    module News
      class Index < Hanami::Action
        include Deps['persistence.rom']

        def handle(*, response)
          news = rom.relations[:news].select(:title, :snippet).limit(10)

          response.body = news.to_a.to_json
          response.status = 200
        end
      end
    end
  end
end
