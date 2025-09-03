class AddArchivedToSchoolClasses < ActiveRecord::Migration[6.1]
  def change
    # rubocop:disable Rails/ThreeStateBooleanColumn
    add_column :school_classes, :archived, :boolean
    # rubocop:enable Rails/ThreeStateBooleanColumn
  end
end
