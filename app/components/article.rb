# frozen_string_literal: true
module Trends
  module Components
    class Article
      attr_accessor :title, :snippet, :url, :source, :country_code

      def initialize(title, snippet, url, source, country_code)
        @title = title
        @snippet = snippet
        @url = url
        @source = source
        @country_code = country_code
      end
    end
  end
end

