class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.integer :created_by
      t.integer :given_to

      t.timestamps
    end
    add_foreign_key :foods, :users, column: :created_by
    add_index :foods, :created_by
    add_foreign_key :foods, :users, column: :given_to
    add_index :foods, :given_to
  end
end
