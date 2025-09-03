class AddGraduatedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :graduated, :boolean
  end
end
