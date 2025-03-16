# frozen_string_literal: true

Hanami.app.register_provider(:custom_parser) do
  prepare do
    require 'feedjira'
  end

  start do
    module Feedjira
      module Parser
        class RSSEntry
          element 'ht:news_item_title', as: :news_item_title
          element 'ht:news_item_snippet', as: :news_item_snippet
          element 'ht:news_item_url', as: :news_item_url
          element 'ht:news_item_source', as: :news_item_source
          element 'ht:news_item_picture', as: :news_item_picture
          element 'pubDate', as: :published
          elements 'ht:news_item', as: :news_item
        end
      end
    end

    parser = Feedjira::Parser::RSSEntry.new

    register 'custom_parser', parser
  end
end
