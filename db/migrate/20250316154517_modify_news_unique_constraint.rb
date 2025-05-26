# frozen_string_literal: true

ROM::SQL.migration do
  up do
    # Drop the index with CASCADE to remove dependent constraints
    run 'DROP INDEX news_url_key CASCADE;'

    # Add the new composite unique constraint
    alter_table :news do
      add_unique_constraint %i[code url], name: :news_code_url_unique
    end
  end

  down do
    # Revert the changes in case of rollback
    alter_table :news do
      drop_constraint :news_code_url_unique, if_exists: true
      add_index :url, unique: true, name: :news_url_key
    end
  end
end
