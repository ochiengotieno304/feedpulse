# frozen_string_literal: true

module Trends
  module Actions
    module News
      class Index < Trends::Action
        include Deps['persistence.rom']

        params do
          optional(:page).value(:integer, gt?: 0)
          optional(:per_page).value(:integer, gt?: 0, lteq?: 100)
          optional(:country).value(:string, max_size?: 2)
        end

        def handle(request, response)
          scopes = request.env.values_at :scopes
          return unless scopes.first.include?('view_news')

          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          country_code = request.params[:country]&.upcase
          news_relation = rom.relations[:news].select(:title, :snippet, :url, :source, :code)
          news_relation = news_relation.where(code: country_code) if country_code
          news_relation = news_relation.order(Sequel.desc(:date))
          news_relation = news_relation.page(request.params[:page] || 1)
          news_relation = news_relation.per_page(request.params[:per_page] || 10)
          news = news_relation.to_a

          response.format = :json
          response.body = news.to_json
        end
      end
    end
  end
end
