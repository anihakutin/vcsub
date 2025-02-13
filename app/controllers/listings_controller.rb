class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :mark_as_sold]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = if user_signed_in? && params[:my_listings]
      # Show all of current user's listings regardless of status
      current_user.listings
    else
      # For public view, show available listings + user's pending + sold listings
      base_query = Listing.where(status: ['available', 'sold'])
      if user_signed_in?
        base_query = base_query.or(Listing.where(user: current_user, status: 'pending'))
      end
      base_query
    end

    # Apply status filter
    if params[:status].present?
      case params[:status]
      when 'sold'
        @listings = @listings.where(status: 'sold')
      when 'pending'
        @listings = user_signed_in? ? @listings.where(status: 'pending') : @listings.none
      when 'available'
        @listings = @listings.where(status: 'available')
      end
    else
      # Default to available when no status is specified
      @listings = @listings.where(status: 'available')
    end
    
    # Apply other filters if present
    @listings = @listings.order(created_at: :desc)
    @listings = @listings.where(city: params[:city]) if params[:city].present?
    @listings = @listings.where(state: params[:state]) if params[:state].present?
    @listings = @listings.where(zip_code: params[:zip_code]) if params[:zip_code].present?
    
    # Get unique cities for the filter
    @cities = Listing.distinct.pluck(:city).compact.sort
    @states = Listing.distinct.pluck(:state).compact.sort
    
    @listings = @listings.page(params[:page]).per(6)
  end

  def show
    @listing.increment_views
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = current_user.listings.new(listing_params)
    @listing.status = 'pending' # Ensure new listings start as pending

    if @listing.save
      redirect_to @listing, notice: "Listing created successfully! It will be reviewed and go live within the next couple of hours."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing, notice: 'Listing was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_url, notice: 'Listing was successfully removed.'
  end

  def mark_as_sold
    @listing.mark_as_sold!
    redirect_to @listing, notice: 'Listing has been marked as sold!'
  end

  private

  def set_listing
    @listing = Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(
      :title, 
      :description, 
      :price, 
      :category,
      :condition,
      :city,
      :state,
      :zip_code,
      :status,
      images: []
    )
  end
end 