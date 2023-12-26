# frozen_string_literal: true

module Trends
  class Routes < Hanami::Routes
    scope 'api' do
      scope 'feeds' do
        use AuthCheck
        get '/', to: 'news.index'
      end
    end

    get '/ping', to: ->(_env){[200, {}, ['it works']]}

    slice :account, at: '/admin' do
      post '/new', to: ->(_env) { [200, {}, ['Deprecated, use https://rapidapi.com/ochiengotieno304/api/feedpulse2 to access FeedPulse']] }
    end

    slice :admin, at: '/admin' do
      use JwtAuth
      get '/users', to: 'users.index'
      get '/news', to: 'news.index'
    end
  end
end
