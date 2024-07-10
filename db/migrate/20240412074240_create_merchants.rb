class CreateMerchants < ActiveRecord::Migration[7.1]
  def change
    create_table :merchants, primary_key: :merchant_id do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :avatar_img_url
      t.timestamps
    end
    # add_column :merchants, :bank_detail, :string # Added from schema.rb
  end
end
