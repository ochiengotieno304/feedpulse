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
      post '/new', to: 'users.create'
    end
  end
end
