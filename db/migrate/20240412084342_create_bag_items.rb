class CreateBagItems < ActiveRecord::Migration[7.1]
  def change
    create_table :bag_items do |t|
      t.integer :quantity
      t.timestamps
    end
  end
end
