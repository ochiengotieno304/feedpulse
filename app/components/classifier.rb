# frozen_string_literal: true

require 'classifier-reborn'

module Trends
  module Components
    class Classifier
      category_data = File.read('category_classifier.dat')
      @category_classifier = Marshal.load category_data

      language_data = File.read('language_classifier.dat')
      @language_classifier = Marshal.load language_data

      def self.category_classifier(snippet)
        @category_classifier.classify snippet
      end

      def self.language_classifier(snippet)
        @language_classifier.classify snippet
      end
    end
  end
end
