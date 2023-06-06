# frozen_string_literal: true

module Trends
  class Routes < Hanami::Routes
    # use JwtAuth

    scope 'api' do
      scope 'auth' do
        post '/account', to: 'users.create'
      end
      get '/feeds', to: 'news.index'

      scope 'feeds' do
        use JwtAuth
        get '/', to: 'news.index'
      end

      scope 'tokens' do
        use JwtAuth
        post '/refresh', to: 'token.update'
      end
    end
  end
end
