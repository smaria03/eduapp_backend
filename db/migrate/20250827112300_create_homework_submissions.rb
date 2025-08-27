class CreateHomeworkSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :homework_submissions do |t|
      t.references :homework, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :homework_submissions, [:homework_id, :student_id], unique: true
  end
end
