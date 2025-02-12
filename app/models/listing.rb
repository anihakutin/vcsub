class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, nil]
    attachable.variant :medium, resize_to_limit: [800, nil]
    attachable.variant :social, resize_to_limit: [1200, 630]
  end
  
  validates :title, :description, :price, :category, :condition, presence: true
  validates :status, inclusion: { in: %w[available sold] }
  validate :validate_image_size
  validate :validate_image_type

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
      image.variant(:medium).processed.url(expires_in: 1.week)
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

  private

  def validate_image_size
    return unless images.attached?

    images.each do |image|
      if image.blob.byte_size > 5.megabytes
        errors.add(:images, "#{image.blob.filename} is too large (maximum is 5MB)")
      end
    end
  end

  def validate_image_type
    return unless images.attached?

    images.each do |image|
      unless image.blob.content_type.in?(%w[image/jpeg image/png image/jpg])
        errors.add(:images, "#{image.blob.filename} must be a JPEG or PNG")
      end
    end
  end
end 