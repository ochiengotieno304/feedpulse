require 'httparty'

module Trends
  module Operations
    class UpdateNews
      include Deps['components.countries', 'parsers.rss_entry']

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

            # article = Article.new(article_title, article_snippet, article_url, article_source, code)

            request_headers = { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' }
            params = { item: { title: article_title, snippet: article_snippet, url: article_url, source: article_source, code: code } }

            post '/news', params.to_json, request_headers
          end
        rescue StandardError => e
          puts "Error: #{e.message}"
        end
      end
    end
  end
end