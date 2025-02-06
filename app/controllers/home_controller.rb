class HomeController < ApplicationController
  def index
    @listings = Listing.order(created_at: :desc).limit(3)
    @requests = Request.order(created_at: :desc).limit(3)
  end
end 