class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :role, presence: true
  has_many :claims, foreign_key: :user_id
  has_many :favorites, foreign_key: :user_id
end
