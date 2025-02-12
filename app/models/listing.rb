class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, nil]
  end
  
  validates :title, :description, :price, :category, :condition, presence: true
  validates :status, inclusion: { in: %w[available sold] }

  scope :available, -> { where(status: 'available') }
  scope :sold, -> { where(status: 'sold') }

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
  
  def image_urls
    images.map do |image|
      image.url(expires_in: 1.week)
    end
  end

  def increment_views
    increment!(:views_count)
  end

  def mark_as_sold!
    update!(status: 'sold')
  end

  def sold?
    status == 'sold'
  end

  def available?
    status == 'available'
  end
end 