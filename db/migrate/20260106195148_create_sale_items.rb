class CreateSaleItems < ActiveRecord::Migration[5.0]
  def change
    create_table :sale_items do |t|
      t.references :sale, foreign_key: true
      t.references :metal, foreign_key: true
      t.references :purity, foreign_key: true
      t.references :jewellery_category, foreign_key: true
      t.decimal :weight, precision: 10, scale: 3
      t.decimal :rate, precision: 10, scale: 2
      t.string :making_type
      t.decimal :making_value, precision: 10, scale: 2
      t.decimal :metal_value, precision: 12, scale: 2
      t.decimal :making_amount, precision: 12, scale: 2
      t.decimal :total_line_amount, precision: 12, scale: 2
    end
  end
end