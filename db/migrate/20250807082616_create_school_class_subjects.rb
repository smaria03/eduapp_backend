class CreateSchoolClassSubjects < ActiveRecord::Migration[6.1]
  def change
    create_table :school_class_subjects do |t|
      t.references :school_class, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
