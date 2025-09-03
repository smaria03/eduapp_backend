class CreateSchoolClassArchives < ActiveRecord::Migration[6.1]
  def change
    create_table :school_class_archives do |t|
      t.references :school_class, null: false, foreign_key: true
      t.string :label
      t.datetime :archived_at
      t.jsonb :data

      t.timestamps
    end

    add_index :school_class_archives, [:school_class_id, :label], unique: true
  end
end
