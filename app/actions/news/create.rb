# frozen_string_literal: true

module Trends
  module Actions
    module News
      class Create < Trends::Action
        include Deps['persistence.rom']

        params do
          required(:item).hash do
            required(:title).filled(:string)
            required(:snippet).filled(:string)
            required(:url).filled(:string)
            required(:source).filled(:string)
            required(:code).filled(:string)
          end
        end

        def handle(request, response)
          if request.params.valid?
            news_item = rom.relations[:news].changeset(:create, request.params[:item]).commit
            response.status = 201
            response.body = news_item.to_json
          else
            response.status = 422
            response.format = :json
            response.body = request.params.errors.to_json
          end
        end
      end
    end
  end
end
