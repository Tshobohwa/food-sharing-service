class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, dependent: :destroy
  belongs_to :food, foreign_key: :food_id, dependent: :destroy
end
