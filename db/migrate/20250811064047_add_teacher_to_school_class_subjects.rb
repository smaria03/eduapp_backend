class AddTeacherToSchoolClassSubjects < ActiveRecord::Migration[6.1]
  def change
    add_reference :school_class_subjects, :teacher, foreign_key: { to_table: :users }, null: true
    add_index :school_class_subjects, [:school_class_id, :subject_id], unique: true, name: 'idx_unique_class_subject'
  end
end
