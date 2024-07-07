class CreateShoppers < ActiveRecord::Migration[7.1]
  def change
    create_table :shoppers, primary_key: :shopper_id do |t|
      t.string :name
      t.string :email, null: false
      t.string :password_digest
      t.timestamps null: false
    end
  end
end
