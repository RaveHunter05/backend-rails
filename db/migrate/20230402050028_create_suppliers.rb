class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :contact_person
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end
