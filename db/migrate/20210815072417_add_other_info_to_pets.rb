class AddOtherInfoToPets < ActiveRecord::Migration[6.1]
  def change
    add_column :pets, :other_info, :string
  end
end
