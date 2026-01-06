class CreateSales < ActiveRecord::Migration[5.0]
  def change
    create_table :sales do |t|
      t.references :user, foreign_key: true
      t.date :sale_date
      t.decimal :subtotal
      t.decimal :making_total
      t.decimal :cgst
      t.decimal :sgst
      t.decimal :total_amount
    end
  end
end
