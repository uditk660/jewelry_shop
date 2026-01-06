class CreateStockLedgers < ActiveRecord::Migration[5.0]
  def change
    create_table :stock_ledgers do |t|
      t.references :metal, foreign_key: true
      t.references :purity, foreign_key: true
      t.references :jewellery_category, foreign_key: true
      t.references :user, foreign_key: true
      t.string :transaction_type, null: false # 'in' or 'out'
      t.decimal :weight, precision: 10, scale: 3
      t.decimal :rate, precision: 12, scale: 2
      t.decimal :value, precision: 14, scale: 2
      t.string :referenceable_type
      t.integer :referenceable_id
      t.text :notes
      t.timestamps
    end

    add_index :stock_ledgers, [:referenceable_type, :referenceable_id]
  end
end