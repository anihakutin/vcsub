class Request < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :budget, numericality: { greater_than: 0 }, allow_nil: true
  validates :status, inclusion: { in: %w[open fulfilled] }
  
  CATEGORIES = [
    "Engineering & Design",
    "Growth & Marketing",
    "Sales & Business Development",
    "Customer Success",
    "Operations",
    "Office Furniture",
    "Electronics & Computers",
    "Phone Booths & Meeting Spaces",
    "Monitors & Displays",
    "Kitchen Equipment",
    "Storage Solutions",
    "Networking Equipment",
    "Other Equipment"
  ]

  scope :open, -> { where(status: 'open') }
  scope :fulfilled, -> { where(status: 'fulfilled') }

  def increment_views
    increment!(:views_count)
  end

  def mark_as_fulfilled!
    update!(status: 'fulfilled')
  end

  def fulfilled?
    status == 'fulfilled'
  end

  def open?
    status == 'open'
  end
end 