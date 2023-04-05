class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :supplier, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.date :order_date
      t.date :estimated_delivery_date
      t.date :actual_delivery_date

      t.timestamps
    end
  end
end
