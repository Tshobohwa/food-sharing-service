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
  end
end
