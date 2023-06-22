# frozen_string_literal: true

module Account
  module Actions
    module Users
      class Create < Hanami::Action
        include Deps['persistence.rom']

        params do
          required(:username).filled(:string, format?: /^[a-zA-Z][a-zA-Z0-9_]{3,29}$/)
          required(:email).filled(:string, format?: /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,6}$/)
        end

        def handle(request, response)
          halt 422, { errors: request.params.errors }.to_json unless request.params.valid?

          api_key = Components::APIKey.new
          username = request.params[:username]
          email = request.params[:email]
          begin
            rom.relations[:users].changeset(:create, username:, email:,
                                                     api_key: api_key.api_key_encrypted).commit

            response.body = { message: 'account registered successfully',
                              user_details: { username:, email:, api_key: api_key.api_key } }.to_json
            response.status = 201
          rescue StandardError => e
            if e.message.include?('users_username_key')
              halt 409, { errors: 'username unavailable' }.to_json
            elsif e.message.include?('users_email_key')
              halt 409, { errors: 'email unavailable' }.to_json
            else
              halt 500, { errors: 'server error, request failed' }.to_json
            end
          end
        end
      end
    end
  end
end
