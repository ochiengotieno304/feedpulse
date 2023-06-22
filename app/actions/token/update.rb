# frozen_string_literal: true

module Trends
  module Actions
    module Token
      class Update < Trends::Action
        include Deps['persistence.rom', 'auth']

        params do
          required(:refresh_token).filled(:string)
        end

        def handle(request, response)
          # scopes = request.env.values_at :scopes
          # return unless scopes.first.include?('refresh_token')

          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          user = request.env.values_at :user
          user_id = user[0]['id']
          user = rom.relations[:users].by_pk(user_id).one

          if user[:refresh_token] == request.params[:refresh_token]

            tokens = Auth::Auth.token(user_id)
            user = rom.relations[:users].by_pk(user_id)
                      .changeset(:update, refresh_token: tokens[:refresh_token]).commit

            response.status = 200
            response.body = { message: 'ensure you save your refresh token to prevent admin loss', user:,
                              token: tokens[:access_token] }.to_json
          else
            response.status = 200
            response.body = { errors: 'token mismatch' }.to_json
          end
        rescue StandardError
          halt 500, { errors: 'request failed' }.to_json
        end
      end
    end
  end
end
