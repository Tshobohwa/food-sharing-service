class CreateClaims < ActiveRecord::Migration[7.1]
  def change
    create_table :claims do |t|
      t.integer :user_id
      t.integer :food_id

      t.timestamps
    end
  end
end
