class CreateQuizAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_answers do |t|
      t.references :quiz_submission, null: false, foreign_key: true
      t.references :quiz_question, null: false, foreign_key: true
      t.integer :selected_option_ids, array: true, default: []

      t.timestamps
    end
  end
end
