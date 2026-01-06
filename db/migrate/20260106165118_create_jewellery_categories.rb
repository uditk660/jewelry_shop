class CreateJewelleryCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :jewellery_categories do |t|
      t.references :metal, foreign_key: true
      t.string :name
      t.boolean :active

      t.timestamps
    end
  end
end
