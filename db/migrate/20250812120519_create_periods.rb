class CreatePeriods < ActiveRecord::Migration[6.1]
  def change
    create_table :periods do |t|
      t.time :start_time
      t.time :end_time
      t.string :label

      t.index [:start_time, :end_time], unique: true, name: 'idx_periods_unique_range'

      t.timestamps
    end
  end
end
