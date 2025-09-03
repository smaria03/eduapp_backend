class FixDefaultsForArchivedAndGraduated < ActiveRecord::Migration[6.1]
  def up
    SchoolClass.where(archived: nil).find_each do |klass|
      klass.update!(archived: false)
    end

    User.where(graduated: nil).find_each do |user|
      user.update!(graduated: false)
    end

    change_table :school_classes, bulk: true do |t|
      t.change_default :archived, false
      t.change_null :archived, false
    end

    change_table :users, bulk: true do |t|
      t.change_default :graduated, false
      t.change_null :graduated, false
    end
  end

  def down
    change_table :school_classes, bulk: true do |t|
      t.change_null :archived, true
      t.change_default :archived, nil
    end

    change_table :users, bulk: true do |t|
      t.change_null :graduated, true
      t.change_default :graduated, nil
    end
  end
end
