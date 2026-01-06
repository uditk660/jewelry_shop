class CreateMetals < ActiveRecord::Migration[5.0]
  def change
    create_table :metals do |t|
      t.string :name, null: false
      t.string :base_unit, default: "gram"
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :metals, :name, unique: true
  end
end
