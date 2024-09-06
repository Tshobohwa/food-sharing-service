class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :food_id

      t.timestamps
    end
    add_foreign_key :favorites, :users, column: :user_id
    add_index :favorites, :user_id
    add_foreign_key :favorites, :foods, column: :food_id
    add_index :favorites, :food_id
  end
end
