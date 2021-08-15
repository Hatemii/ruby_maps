class RemoveFoundOnFromPets < ActiveRecord::Migration[6.1]
  def change
    remove_column :pets, :found_on, :datetime
  end
end
