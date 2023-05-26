# frozen_string_literal: true

ROM::SQL.migration do
  change do
    def up
      change_column :users, :id, :text
    end

    def down
      change_column :users, :id, :int
    end
  end
end
