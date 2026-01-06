class AddUnitsToStockLedgers < ActiveRecord::Migration[5.0]
  def change
    add_column :stock_ledgers, :unit, :integer, default: 0
  end
end
