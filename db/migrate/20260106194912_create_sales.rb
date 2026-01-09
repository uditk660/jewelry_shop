class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.references :user, foreign_key: true
      t.date :sale_date
      t.decimal :subtotal, precision: 12, scale: 2, default: 0
      t.decimal :making_total, precision: 12, scale: 2, default: 0
      t.decimal :cgst, precision: 12, scale: 2, default: 0
      t.decimal :sgst, precision: 12, scale: 2, default: 0
      t.decimal :total_amount, precision: 12, scale: 2, default: 0
    end
  end
end