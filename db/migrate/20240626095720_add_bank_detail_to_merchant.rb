class AddBankDetailToMerchant < ActiveRecord::Migration[7.1]
  def change
    add_column :merchants, :bank_detail, :string
  end
end
