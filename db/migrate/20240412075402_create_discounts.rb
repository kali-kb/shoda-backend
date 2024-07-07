class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts, primary_key: :discount_id do |t|
      t.integer :rate
      t.date :expiry
      t.timestamps
    end
  end
end
