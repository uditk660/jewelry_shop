class AddUpdatedPriceToPurities < ActiveRecord::Migration[5.0]
  def change
    add_column :purities, :updated_price, :decimal, precision: 12, scale: 2
    add_column :purities, :remarks, :string
  end
end
