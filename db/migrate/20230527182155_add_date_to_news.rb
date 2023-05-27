# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :news do
      add_column :date, :date, null: false, default: Sequel::CURRENT_DATE
    end
  end
end
