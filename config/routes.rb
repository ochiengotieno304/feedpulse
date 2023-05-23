# frozen_string_literal: true

module Trends
  class Routes < Hanami::Routes
    root to: "news.index"
    # get "/home/:id", to: "home.show"
    # get "/news", to: "news.index"
    # post "/news", to: "news.create"
  end
end
