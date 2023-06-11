# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :users do
      add_column :api_key, :text, null: false
    end
  end
end
