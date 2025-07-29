# frozen_string_literal: true

class RemoveUniqueIndexFromUsersEmail < ActiveRecord::Migration[6.1]
  def change
    # rubocop:disable Rails/ReversibleMigration
    remove_index :users, name: 'index_users_on_email'
    # rubocop:enable Rails/ReversibleMigration
  end
end
