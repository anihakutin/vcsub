class Request < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true
  validates :budget, numericality: { greater_than: 0 }, allow_nil: true
  
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
end 