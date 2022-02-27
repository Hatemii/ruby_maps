class CreateRecordDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :record_details do |t|
      t.string :street_number, default: 'not-available'
      t.string :route, default: 'not-available'
      t.string :neighborhood, default: 'not-available'
      t.string :locality, default: 'not-available'
      t.string :country, default: 'not-available'
      t.string :postal_code, default: 'not-available'
      t.references :record_detailable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
