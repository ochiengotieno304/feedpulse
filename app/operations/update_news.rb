# frozen_string_literal: true

require 'httparty'
require 'feedjira'
require 'date'

module Trends
  module Operations
    class UpdateNews
      include Deps['components.countries', 'components.classifier', 'custom_parser', 'persistence.rom']

      def call
        countries = Components::Countries.country_codes
        countries.each do |code|
          url = "https://trends.google.com/trends/trendingsearches/daily/rss?geo=#{code}"
          xml = HTTParty.get(url).body
          feeds = Feedjira.parse(xml)

          feeds.entries.each do |item|
            article_title = item.news_item_title
            article_snippet = item.news_item_snippet
            article_url = item.news_item_url
            article_source = item.news_item_source
            pub_date = Date.parse(item.published.to_s)
            article_category = Components::Classifier.classifier(article_snippet).upcase

            news_item = {
              title: article_title,
              snippet: article_snippet,
              url: article_url,
              source: article_source,
              published_date: pub_date,
              code:,
              category: article_category
            }

            rom.relations[:news].changeset(:create, news_item).commit
          end
        rescue StandardError => e
          puts "Error: #{e.message}"
        end
      end
    end
  end
end
