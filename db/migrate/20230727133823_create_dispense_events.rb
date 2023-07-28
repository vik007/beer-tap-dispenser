class CreateDispenseEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :dispense_events do |t|
      t.references :dispenser, foreign_key: true, index: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :duration, default: 0
      t.float :volume, default: 0.0
      t.float :amount, default: 0.0

      t.timestamps
    end
  end
end
