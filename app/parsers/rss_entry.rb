# frozen_string_literal: true

require 'feedjira'

module Trends
  module Parsers
    class RssEntry < Feedjira::Parser::RSSEntry
      element 'ht:news_item_title', as: :news_item_title
      element 'ht:news_item_snippet', as: :news_item_snippet
      element 'ht:news_item_url', as: :news_item_url
      element 'ht:news_item_source', as: :news_item_source
    end
  end
end

