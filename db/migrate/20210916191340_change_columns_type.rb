class ChangeColumnsType < ActiveRecord::Migration[6.1]
  def change
    change_column :pets, :last_known_latitude, :decimal
    change_column :pets, :last_known_longitude, :decimal
  end
end
