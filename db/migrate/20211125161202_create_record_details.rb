class CreateRecordDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :record_details do |t|
      t.integer :street_number
      t.string :route
      t.string :neighborhood
      t.string :locality
      t.string :country
      t.integer :postal_code
      t.references :record_detailable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
