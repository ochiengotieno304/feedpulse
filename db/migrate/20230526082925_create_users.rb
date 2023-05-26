# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :users do
      primary_key :id
      column :username, :text, null: false, unique: true
      column :email, :text, null: false, unique: true
    end
  end
end
