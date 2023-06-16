# frozen_string_literal: true

module Trends
  class Routes < Hanami::Routes

    scope 'api' do
      scope 'feeds' do
        use AuthCheck
        get '/', to: 'news.index'
      end
    end

    slice :account, at: '/account' do
      post '/new', to: -> (env) { [200, {}, ['Deprecated, use https://rapidapi.com/ochiengotieno304/api/feedpulse2 to access FeedPulse']] }
    end
  end
end
