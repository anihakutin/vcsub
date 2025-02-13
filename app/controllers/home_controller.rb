class HomeController < ApplicationController
  def index
    # For listings: show available + user's pending
    base_listings = Listing.where(status: 'available')
    if user_signed_in?
      base_listings = base_listings.or(Listing.where(user: current_user, status: 'pending'))
    end
    @listings = base_listings.order(created_at: :desc).limit(3)

    # For requests: show open + user's pending
    base_requests = Request.where(status: 'open')
    if user_signed_in?
      base_requests = base_requests.or(Request.where(user: current_user, status: 'pending'))
    end
    @requests = base_requests.order(created_at: :desc).limit(3)

    # Get unique locations for filters
    @cities = (Listing.distinct.pluck(:city) + Request.distinct.pluck(:city)).compact.uniq.sort
    @states = (Listing.distinct.pluck(:state) + Request.distinct.pluck(:state)).compact.uniq.sort
  end
end 