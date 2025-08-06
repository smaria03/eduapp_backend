class AddUniqueIndexToSchoolClassesName < ActiveRecord::Migration[6.1]
  def change
    add_index :school_classes, :name, unique: true
  end
end
