class ChangeColumnType < ActiveRecord::Migration[6.1]
  def change
    change_column :pets, :lost_on, :datetime
  end
end
