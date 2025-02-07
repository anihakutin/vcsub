class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, nil]
  end
  
  validates :title, :description, :price, :category, :condition, presence: true
  validates :initial_valuation, presence: true

  CATEGORIES = [
    "Office Furniture",
    "Hardware (Macbook, Raspberry Pi, Sonos, etc.)",
    "Unused Ping Pong Tables",
    "Promotional Swag",
    "Fancy Coffee Machines",
    "Abandoned Code Repositories",
    "Motivational Posters",
    "Untouched Exercise Equipment",
    "Blockchain Whitepapers",
    "Employees (Highly Skilled)",
  ]
  
  def valuation_difference
    return 0 if initial_valuation.nil?
    ((initial_valuation - price) / initial_valuation.to_f * 100).round(2)
  end
  
  def image_urls
    images.map do |image|
      image.url(expires_in: 1.week)
    end
  end
end 