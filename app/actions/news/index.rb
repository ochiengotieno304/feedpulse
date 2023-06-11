# frozen_string_literal: true

require 'bcrypt'

module Trends
  module Actions
    module News
      class Index < Trends::Action
        include Deps['persistence.rom']
        # include BCrypt

        params do
          optional(:page).value(:integer, gt?: 0)
          optional(:per_page).value(:integer, gt?: 0, lteq?: 100)
          optional(:country).value(:string, max_size?: 2)
          required(:username).filled(:string)
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?
          uname = request.params[:username]
          api_key = request.env.values_at :api_key

          user = rom.relations[:users].where(username: uname).first

          user_check = user[:username] == uname
          api_key_check = BCrypt::Password.new(user[:api_key]) == api_key[0]

          halt 401, { errors: 'invalid user name' }.to_json if user.nil?

          halt 401, { errors: 'invalid api key' }.to_json unless user_check && api_key_check

          # return unless user['username'] == uname && user['api_key'] == api_key

          country_code = request.params[:country]&.upcase
          news_relation = rom.relations[:news].select(:title, :snippet, :url, :source, :code, :date)
          news_relation = news_relation.where(code: country_code) if country_code
          news_relation = news_relation.order(Sequel.desc(:date))
          news_relation = news_relation.page(request.params[:page] || 1)
          news_relation = news_relation.per_page(request.params[:per_page] || 10)
          news = news_relation.to_a

          response.status = 200
          response.format = :json
          response.body = news.to_json
        end
      end
    end
  end
end
