class Request < ApplicationRecord
  belongs_to :user
  
  validates :title, :description, :category, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending open fulfilled] }

  scope :fulfilled, -> { where(status: 'fulfilled') }
  scope :open, -> { where(status: 'open') }
  
  # Add visible scope
  scope :visible, -> { 
    if Current.user
      where(user: Current.user).or(where(status: 'open'))
    else
      where(status: 'open')
    end
  }

  STATUSES = {
    pending: 'pending',
    open: 'open',
    fulfilled: 'fulfilled'
  }

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

  def fulfilled?
    status == 'fulfilled'
  end

  def open?
    status == 'open'
  end

  def pending?
    status == 'pending'
  end

  def increment_views
    increment!(:views_count)
  end
end 