class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers, primary_key: :customer_id do |t|
      t.string :address
      t.string :phone_number, limit: 20
      t.string :city
      t.string :postal_code
      t.timestamps
    end
  end
end
