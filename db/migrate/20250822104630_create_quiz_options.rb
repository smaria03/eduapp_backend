class CreateQuizOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :quiz_options do |t|
      t.references :quiz_question, null: false, foreign_key: true
      t.string :text
      t.boolean :is_correct, null: false, default: false

      t.timestamps
    end
  end
end
