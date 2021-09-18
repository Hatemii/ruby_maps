class RenameColumns < ActiveRecord::Migration[6.1]
  def change
    rename_column :pets, :last_known_latitude, :latitude
    rename_column :pets, :last_known_longitude, :longitude
  end
end
