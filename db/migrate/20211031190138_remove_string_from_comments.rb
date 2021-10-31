class RemoveStringFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :string, :string
  end
end
