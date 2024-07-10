class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :message
      # t.boolean :read, default: false
      t.references :merchant, null: false, foreign_key: {to_table: :merchants, primary_key: :merchant_id}
      t.timestamps
    end
  end
end
