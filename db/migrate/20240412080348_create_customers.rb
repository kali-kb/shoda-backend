class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers, primary_key: :customer_id do |t|
      t.string :address
      t.string :phone_number, limit: 20
      t.string :city
      t.string :postal_code
      t.timestamps
    end
    add_reference :customers, :shopper, foreign_key: {to_table: :shoppers, primary_key: :shopper_id} # Added from schema.rb
  end
end
