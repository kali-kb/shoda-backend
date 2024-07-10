class CreateDiscounts < ActiveRecord::Migration[7.1]
  def change
    create_table :discounts, primary_key: :discount_id do |t|
      t.integer :rate
      t.date :expiry
      t.timestamps
    end
    add_reference :discounts, :merchant, foreign_key: {to_table: :merchants, primary_key: :merchant_id} # Added from schema.rb
    add_reference :discounts, :product, foreign_key: {to_table: :products, primary_key: :product_id} # Added from schema.rb
  end
end
