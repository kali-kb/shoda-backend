class ChangeSizesColumnInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :sizes, :text
  end
end
