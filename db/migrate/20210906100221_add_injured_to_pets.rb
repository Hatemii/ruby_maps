class AddInjuredToPets < ActiveRecord::Migration[6.1]
  def change
    add_column :pets, :injured, :boolean, default: false
  end
end
