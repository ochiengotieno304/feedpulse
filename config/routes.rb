# frozen_string_literal: true

module Trends
  class Routes < Hanami::Routes
    root to: "home.show"
    get "/home/:id", to: "home.show"
    get "/news", to: "news.index"
    post "/news", to: "news.create"
  end
end
