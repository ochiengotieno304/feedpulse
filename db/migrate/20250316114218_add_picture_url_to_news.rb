# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :news do
      add_column :picture_url, :text, default: nil
    end
  end
end
