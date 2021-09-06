class ChangeDateFormatInMyTable < ActiveRecord::Migration[6.1]
  def change
    change_column :pets, :lost_on, :string
  end
end
