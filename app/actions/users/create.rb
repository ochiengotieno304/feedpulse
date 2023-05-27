# frozen_string_literal: true

module Trends
  module Actions
    module Users
      class Create < Trends::Action
        include Deps["persistence.rom"]

        params do
          required(:username).filled(:string, format?: /^[a-zA-Z][a-zA-Z0-9_]{3,29}$/)
          required(:email).filled(:string, format?: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,6}$/)
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          username = request.params[:username]
          email = request.params[:email]
          begin
            new_user = rom.relations[:users].changeset(:create, username: username, email: email).commit
            response.status = 201
            response.body = { message: 'account registered successfully', user: new_user }.to_json
          rescue StandardError => e
            if e.message.include?('users_username_key')
              halt 409, { errors: 'username unavailable' }.to_json
            elsif e.message.include?('users_email_key')
              halt 409, { errors: 'email unavailable' }.to_json
            end
          end
        end
      end
    end
  end
end
