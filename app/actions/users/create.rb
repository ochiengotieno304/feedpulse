# frozen_string_literal: true

module Trends
  module Actions
    module Users
      class Create < Trends::Action
        include Deps['persistence.rom', 'auth']

        params do
          required(:username).filled(:string, format?: /^[a-zA-Z][a-zA-Z0-9_]{3,29}$/)
          required(:email).filled(:string, format?: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,6}$/)
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          username = request.params[:username]
          email = request.params[:email]
          begin
            new_user = rom.relations[:users].changeset(:create, username:, email:).commit # TODO: Save refresh token to db
            response.status = 201
            tokens = Auth::Auth.token(new_user[:id])
            user = rom.relations[:users].by_pk(new_user[:id])
                      .changeset(:update, refresh_token: tokens[:refresh_token]).commit
            response.body = { message: 'admin registered successfully, save refresh token to avoid admin loss',
                              user:, token: tokens[:access_token] }.to_json
          rescue StandardError => e
            if e.message.include?('users_username_key')
              halt 409, { errors: 'username unavailable' }.to_json
            elsif e.message.include?('users_email_key')
              halt 409, { errors: 'email unavailable' }.to_json
            else
              halt 500, { errors: 'request failed' }.to_json
            end
          end
        end
      end
    end
  end
end
