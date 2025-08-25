class CreateQuizSubmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_submissions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.datetime :submitted_at
      t.float :raw_score
      t.float :final_score

      t.timestamps
    end
  end
end
