class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.text :address
      t.string :city
      t.string :pin
      t.string :phone
      t.string :email
      t.string :gst
      t.string :adhaar
      t.string :pan

      t.timestamps
    end
  end
end
