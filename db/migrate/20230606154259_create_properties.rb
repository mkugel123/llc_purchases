class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.bigint :document_id
      t.string :owner_address_1
      t.string :owner_address_2
      t.string :owner
      t.string :property_street_name
      t.string :property_street_number
      t.string :date_on_deed

      t.timestamps
    end
  end
end
