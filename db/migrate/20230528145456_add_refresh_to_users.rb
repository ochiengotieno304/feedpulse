# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :users do
      add_column :refresh_token, :text
    end
  end
end
