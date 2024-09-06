class CreateClaims < ActiveRecord::Migration[7.1]
  def change
    create_table :claims do |t|
      t.integer :user_id
      t.integer :food_id

      t.timestamps
    end
    add_foreign_key :claims, :users, column: :user_id
    add_index :claims, :user_id
    add_foreign_key :claims, :foods, column: :food_id
    add_index :claims, :food_id
  end
end
