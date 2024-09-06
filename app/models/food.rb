class Food < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :quantity, presence: true
  belongs_to :user, foreign_key: :created_by
end
