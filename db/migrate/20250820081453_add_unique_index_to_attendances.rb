class AddUniqueIndexToAttendances < ActiveRecord::Migration[6.1]
  def change
    add_index :attendances, [:user_id, :assignment_id, :period_id, :date], unique: true, name: 'index_attendances_on_unique_columns'
  end
end
