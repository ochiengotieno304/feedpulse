require 'httparty'
require 'feedjira'

module Trends
  module Operations
    class UpdateNews
      include Deps['components.countries', 'custom_parser', 'persistence.rom']

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

            news_item = {
              title: article_title,
              snippet: article_snippet,
              url: article_url,
              source: article_source,
              code: code
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