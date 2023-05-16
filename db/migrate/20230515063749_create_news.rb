# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :news do
      primary_key :id
      column :title, :text, null: false
      column :snippet, :text, null: false
      column :url, :text, null: false, unique: true
      column :source, :text, null: false
      column :code, :text, null: false
    end
  end
end
