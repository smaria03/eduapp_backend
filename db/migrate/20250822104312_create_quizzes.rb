class CreateQuizzes < ActiveRecord::Migration[6.1]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.text :description
      t.datetime :deadline
      t.integer :time_limit
      t.references :assignment, null: false, foreign_key: { to_table: :school_class_subjects }

      t.timestamps
    end
  end
end
