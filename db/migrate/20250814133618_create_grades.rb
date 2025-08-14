class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.integer :value
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
  end
end
