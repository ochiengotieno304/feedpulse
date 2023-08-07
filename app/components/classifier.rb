# frozen_string_literal: true

require 'classifier-reborn'

module Trends
  module Components
    class Classifier
      data = File.read('classifier.dat')
      @trained_classifier = Marshal.load data

      def self.classifier(snippet)
        @trained_classifier.classify snippet
      end
    end
  end
end
