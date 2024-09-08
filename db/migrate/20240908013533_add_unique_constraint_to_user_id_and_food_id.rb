class AddUniqueConstraintToUserIdAndFoodId < ActiveRecord::Migration[7.1]
  def change
    add_index :favorites, [:user_id, :food_id], unique: true
    add_index :claims, [:user_id, :food_id], unique: true
  end
end
