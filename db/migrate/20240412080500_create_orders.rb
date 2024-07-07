class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, primary_key: :order_id do |t|
      t.integer :total_items
      t.integer :total_amount
      t.string :status
      # payment_status
      t.timestamp :date_created
    end
  end
end
