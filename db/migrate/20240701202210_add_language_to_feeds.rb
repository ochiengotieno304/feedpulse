# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :news do
      add_column :language, :text
    end
  end
end