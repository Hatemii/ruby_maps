class ChangeColumnTypes < ActiveRecord::Migration[6.1]
  def change
    change_column :record_details, :street_number, :string
  end
end
