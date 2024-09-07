class Food < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  belongs_to :user, foreign_key: :created_by
  has_many :favorites, foreign_key: :food_id, dependent: :destroy
  has_many :claims, foreign_key: :food_id, dependent: :destroy
end
