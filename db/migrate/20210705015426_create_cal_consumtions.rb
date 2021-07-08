class CreateCalConsumtions < ActiveRecord::Migration[5.2]
  def change
    create_table :cal_consumtions do |t|
      t.integer :cal_consumtion
      t.integer :user_id

      t.timestamps
    end
  end
end
