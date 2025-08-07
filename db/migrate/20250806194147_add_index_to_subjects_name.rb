class AddIndexToSubjectsName < ActiveRecord::Migration[6.1]
  def change
    add_index :subjects, :name, unique: true
  end
end
