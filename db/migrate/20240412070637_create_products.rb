class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, primary_key: :product_id do |t|
      t.string :title
      t.text :description, limit: 1000
      t.integer :price
      t.string :img_url
      t.integer :available_stocks
      # t.string :sizes #array: true length: 5 
      t.text :sizes #from schema.rb
      t.bigint :merchant_id  #from schema.rb
      t.timestamps
    end
  end
end
