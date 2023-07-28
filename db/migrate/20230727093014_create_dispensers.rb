class CreateDispensers < ActiveRecord::Migration[7.0]
  def change
    create_table :dispensers do |t|
      t.float :flow_volume, null: false
      t.integer :duration, default: 0
      t.float :amount, default: 0.0

      t.timestamps
    end
  end
end
