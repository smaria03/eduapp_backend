class AddArchivedToSchoolClasses < ActiveRecord::Migration[6.1]
  def change
    add_column :school_classes, :archived, :boolean
  end
end
