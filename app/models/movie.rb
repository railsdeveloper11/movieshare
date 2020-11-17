class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews
  
  validates :movie_url, presence: true
end
