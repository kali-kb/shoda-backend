class CreateBagItems < ActiveRecord::Migration[7.1]
  def change
    create_table :bag_items, primary_key: :item_id do |t|
      t.integer :quantity
      t.bigint :product_id
      t.bigint :shopper_id
      t.timestamps
    end
      add_index :bag_items, :product_id, name: "index_bag_items_on_product_id"
    add_index :bag_items, :shopper_id, name: "index_bag_items_on_shopper_id"
  end
end
