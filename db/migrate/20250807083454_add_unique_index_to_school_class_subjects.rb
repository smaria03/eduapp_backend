class AddUniqueIndexToSchoolClassSubjects < ActiveRecord::Migration[6.1]
  def change
    add_index :school_class_subjects, [:school_class_id, :subject_id], unique: true, name: 'index_unique_class_subject'
  end
end
