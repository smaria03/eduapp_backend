class ChangeUniqueIndexToEmailOnly < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, name: 'index_users_on_email_and_role'
    add_index :users, :email, unique: true
  end
end
