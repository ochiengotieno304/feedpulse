# frozen_string_literal: true

module Admin
  module Actions
    module Users
      class Index < Hanami::Action
        include Deps['persistence.rom']

        def handle(*, response)
          users = rom.relations[:users].select(:username, :email)

          response.body = users.to_a.to_json
          response.status = 200
        end
      end
    end
  end
end
