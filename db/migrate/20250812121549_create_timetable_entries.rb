class CreateTimetableEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :timetable_entries do |t|
      t.references :assignment, null: false, foreign_key: { to_table: :school_class_subjects }
      t.integer :weekday, null: false
      t.references :period, null: false, foreign_key: true

      t.index [:assignment_id, :weekday, :period_id], unique: true, name: 'idx_unique_assignment_day_period'
      t.index [:weekday, :period_id], name: 'idx_timetable_day_period'

      t.timestamps
    end
  end
end
