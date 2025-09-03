class SetDefaultGraduatedFalseForUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :graduated, from: nil, to: false
  end
end
