# frozen_string_literal: true

ROM::SQL.migration do
  change do
    run 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    alter_table :users do
      drop_constraint :users_pkey
      drop_column :id
      add_column :id, :uuid, primary_key: true, default: Sequel.function(:uuid_generate_v4)
    end
  end
end
