class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :text
      t.string :string
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
