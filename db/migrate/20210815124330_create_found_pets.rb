class CreateFoundPets < ActiveRecord::Migration[6.1]
  def change
    create_table :found_pets do |t|
      t.datetime :found_on
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
