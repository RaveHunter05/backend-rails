class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.date :sale_date
      t.string :customer_name

      t.timestamps
    end
  end
end
