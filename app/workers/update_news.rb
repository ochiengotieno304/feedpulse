# frozen_string_literal: true

module Trends
  module Workers
    class UpdateNews
      include Sidekiq::Job

      include Deps['operations.update_news']

      def perform
        update_news.call
      end
    end
  end
end