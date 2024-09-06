class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :food, foreign_key: :food_id
end
