class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, primary_key: :order_id do |t|
      t.integer :total_items
      t.integer :total_amount
      t.string :status
      # payment_status
      t.timestamp :date_created
    end
    add_reference :orders, :customer, foreign_key: {to_table: :customers, primary_key: :customer_id} # Added from schema.rb
    add_reference :orders, :merchant, foreign_key: {to_table: :merchants, primary_key: :merchant_id} # Added from schema.rb
    # add_column :orders, :order_number, :string
    # add_index :orders, :customer_id # Added from schema.rb
    # add_index :orders, :merchant_id # Added from schema.rb
  end
end
