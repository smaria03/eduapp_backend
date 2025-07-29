# frozen_string_literal: true

class AddUniqueIndexToEmailAndRole < ActiveRecord::Migration[6.1]
  def change
    add_index :users, %i[email role], unique: true
  end
end
