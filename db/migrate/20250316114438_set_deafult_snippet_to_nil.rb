# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :news do
      set_column_allow_null :snippet, true
    end
  end
end
