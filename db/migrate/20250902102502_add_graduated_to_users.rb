class AddGraduatedToUsers < ActiveRecord::Migration[6.1]
  def change
    # rubocop:disable Rails/ThreeStateBooleanColumn
    add_column :users, :graduated, :boolean
    # rubocop:enable Rails/ThreeStateBooleanColumn
  end
end
