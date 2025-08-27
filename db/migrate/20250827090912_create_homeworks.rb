class CreateHomeworks < ActiveRecord::Migration[6.1]
  def change
    create_table :homeworks do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.references :assignment, null: false, foreign_key: { to_table: :school_class_subjects }

      t.timestamps
    end
  end
end
