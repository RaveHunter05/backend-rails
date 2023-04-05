class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :sku
      t.string :category
      t.string :manufacturer
      t.decimal :cost
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end
end
