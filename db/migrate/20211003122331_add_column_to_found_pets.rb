class AddColumnToFoundPets < ActiveRecord::Migration[6.1]
  def change
    add_column :found_pets, :species, :string
    add_column :found_pets, :breed, :string
    add_column :found_pets, :search, :string
    add_column :found_pets, :latitude, :decimal
    add_column :found_pets, :longitude, :decimal
    add_column :found_pets, :other_info, :string
    add_column :found_pets, :injured, :boolean, default: false
    add_reference :found_pets, :user, null: false, foreign_key: true
  end
end
