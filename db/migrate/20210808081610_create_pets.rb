class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :name
      t.string :description
      t.string :species
      t.string :breed
      t.datetime :found_on 
      t.datetime :lost_on
      t.float :last_known_latitude
      t.float :last_known_longitude

      t.timestamps
    end
  end
end
