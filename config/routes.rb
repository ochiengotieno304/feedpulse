# frozen_string_literal: true

module Trends
  class Routes < Hanami::Routes
    # use JwtAuth

    # root to: 'news.index'
    # get "/home/:id", to: "home.show"
    # get "/news", to: "news.index"
    # post "/news", to: "news.create"

    scope 'api' do
      scope 'auth' do
        post '/account', to: 'users.create'
      end

      scope 'feeds' do
        # use JwtAuth
        get '/', to: 'news.index'
      end

      scope 'tokens' do
        use JwtAuth
        post '/refresh', to: 'token.update'
      end
    end
  end
end
