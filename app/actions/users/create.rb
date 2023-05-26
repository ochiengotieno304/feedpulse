# frozen_string_literal: true

module Trends
  module Actions
    module Users
      class Create < Trends::Action
        include Deps["persistence.rom"]

        params do
          required(:user).hash do
            required(:username).filled(:string, format?: /^[a-zA-Z][a-zA-Z0-9_]{3,29}$/)
            required(:email).filled(:string, format?: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,6}$/)
          end
        end

        def handle(request, response)
          if request.params.valid?
            new_user = rom.relations[:users].changeset(:create, request.params[:user]).commit
            response.status = 201
            response.body = new_user.to_json
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
