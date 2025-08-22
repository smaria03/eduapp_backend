class CreateLearningMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_materials do |t|
      t.string :title
      t.text :description
      t.references :assignment, null: false, foreign_key: { to_table: :school_class_subjects }

      t.timestamps
    end
  end
end
