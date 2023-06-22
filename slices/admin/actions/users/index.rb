# frozen_string_literal: true

module Admin
  module Actions
    module Users
      class Index < Admin::Action
        include Deps['persistence.rom']

        def handle(*, response)
          response.body = { "message": 'hello' }.to_json
          response.status = 200
        end
      end
    end
  end
end
