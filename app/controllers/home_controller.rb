class HomeController < ApplicationController
  def index
    @listings = Listing.order(created_at: :desc).limit(6)
  end
end 