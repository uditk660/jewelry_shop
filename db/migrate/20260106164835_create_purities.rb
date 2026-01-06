class CreatePurities < ActiveRecord::Migration[5.0]
  def change
    create_table :purities do |t|
      t.references :metal, foreign_key: true
      t.string  :name, null: false
      t.decimal :purity_percent, precision: 5, scale: 2
      t.boolean :active, default: true

      t.timestamps
    end
  end
end