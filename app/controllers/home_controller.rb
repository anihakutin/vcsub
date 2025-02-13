class HomeController < ApplicationController
  def index
    @listings = Listing.available
                      .order(created_at: :desc)
                      .limit(3)
    
    @requests = Request.open
                      .order(created_at: :desc)
                      .limit(3)
  end
end 