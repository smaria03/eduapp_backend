class SetDefaultArchivedFalseForSchoolClasses < ActiveRecord::Migration[6.1]
  def change
    change_column_default :school_classes, :archived, from: nil, to: false
  end
end
