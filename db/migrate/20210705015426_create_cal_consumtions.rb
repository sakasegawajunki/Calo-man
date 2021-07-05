class CreateCalConsumtions < ActiveRecord::Migration[5.2]
  def change
    create_table :cal_consumtions do |t|
      t.integer :cal_consumtion

      t.timestamps
    end
  end
end
