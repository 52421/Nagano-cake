class CreateOrdersItems < ActiveRecord::Migration[6.1]
  def change
    create_table :orders_items do |t|
      t.integer :item_id, null: false
      t.integer :orders_id, null: false
      t.integer :price, null: false
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
