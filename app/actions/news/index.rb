# frozen_string_literal: true

require 'bcrypt'

module Trends
  module Actions
    module News
      class Index < Trends::Action
        include Deps['persistence.rom']

        params do
          optional(:page).value(:integer, gt?: 1)
          optional(:per_page).value(:integer, gt?: 1, lteq?: 100)
          optional(:country).value(:string, max_size?: 2)
          required(:username).filled(:string)
          required(:api_key).filled(:string)
        end

        def handle(request, response)
          proxy_secret = request.env.values_at(:proxy_secret)
          valid_proxy_secret = proxy_secret[0] == ENV['RAPID_API_PROXY_SECRET']

          puts proxy_secret[0]

          if valid_proxy_secret
            process_request(request, response)
          else
            handle_authenticated_request(request, response)
          end
        rescue StandardError
          halt(500, { errors: 'internal server error' }.to_json)
        end

        private

        def process_request(request, response)
          news = retrieve_news(request)
          construct_response(response, news)
        end

        def handle_authenticated_request(request, response)
          halt(422, { errors: request.params.errors }.to_json) unless request.params.valid?

          uname = request.params[:username]
          api_key = request.env.values_at(:api_key)[0]

          user = rom.relations[:users].where(username: uname).first

          user_check = user[:username] == uname
          api_key_check = BCrypt::Password.new(user[:api_key]) == api_key

          halt(403, { errors: 'invalid username or api key' }.to_json) unless user_check && api_key_check

          news = retrieve_news(request)
          construct_response(response, news)
        end

        def retrieve_news(request)
          country_code = request.params[:country]&.upcase
          news_category = request.params[:category]&.upcase
          news_relation = rom.relations[:news].select(:title, :snippet, :url, :source, :code, :category, :date)
          news_relation = news_relation.where(code: country_code) if country_code
          news_relation = news_relation.where(category: news_category) if news_category
          news_relation = news_relation.order(Sequel.desc(:date))
          news_relation = news_relation.page(request.params[:page] || 1)
          news_relation = news_relation.per_page(request.params[:per_page] || 10)
          news_relation.to_a
        end

        def construct_response(response, news)
          response.status = 200
          response.format = :json
          response.body = news.to_json
        end
      end
    end
  end
end
