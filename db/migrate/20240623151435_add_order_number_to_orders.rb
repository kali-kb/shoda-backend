class AddOrderNumberToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :order_number, :string
  end
end
