class Restaurant < ApplicationRecord

  belongs_to :user
  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy

  validates :name, length: {minimum: 3}, uniqueness: true

  def average_rating
    total = 0
    count = 0
    reviews.each do |review|
      total += review.rating
      count += 1
    end
    average = total / count
  end

  def stars_rating
    black_star = "\u2605"
    white_star = "\u2606"
    stars_output = ""
    stars_output += (black_star * average_rating) + (white_star * (5 - average_rating))
  end
end
