class CreateAttendances < ActiveRecord::Migration[6.1]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assignment, null: false, foreign_key: { to_table: :school_class_subjects }
      t.references :period, null: false, foreign_key: true
      t.date :date
      t.integer :status

      t.timestamps
    end
  end
end
