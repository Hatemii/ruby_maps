class RemovePetIdFromFoundPets < ActiveRecord::Migration[6.1]
  def change
    remove_column :found_pets, :pet_id, :integer
  end
end
