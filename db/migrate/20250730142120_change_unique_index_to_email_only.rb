class ChangeUniqueIndexToEmailOnly < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, column: [:email, :role]
    add_index :users, :email, unique: true
  end
end
