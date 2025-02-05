class Listing < ApplicationRecord
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [300, nil]
  end
  
  validates :title, :description, :price, :category, :condition, presence: true
  validates :initial_valuation, :runway_end_date, presence: true
  
  def runway_days_remaining
    return 0 if runway_end_date.nil? || runway_end_date < Date.today
    (runway_end_date - Date.today).to_i
  end
  
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