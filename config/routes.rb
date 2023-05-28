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
        post '/signup', to: 'users.create'
      end

      scope 'feeds' do
        use JwtAuth
        get '/', to: 'news.index'
      end
    end
    patch "/token/:id", to: "token.update"
  end
end
