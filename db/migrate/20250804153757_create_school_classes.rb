class CreateSchoolClasses < ActiveRecord::Migration[6.1]
  def change
    create_table :school_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
