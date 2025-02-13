class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :mark_as_sold]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = if user_signed_in? && params[:my_listings]
      # Show all of current user's listings regardless of status
      current_user.listings.order(created_at: :desc)
    else
      # For public view, only show available listings
      base_query = Listing.where(status: 'available')
      
      # If user is signed in, also include their pending listings
      if user_signed_in?
        base_query = base_query.or(Listing.where(user: current_user, status: 'pending'))
      end
      
      base_query.order(created_at: :desc)
    end

    # Apply status filter only for my_listings view
    if user_signed_in? && params[:my_listings] && params[:status].present?
      @listings = @listings.where(status: params[:status])
    end
    
    # Apply other filters if present
    @listings = @listings.where(city: params[:city]) if params[:city].present?
    @listings = @listings.where(state: params[:state]) if params[:state].present?
    @listings = @listings.where(zip_code: params[:zip_code]) if params[:zip_code].present?
    
    # Get unique cities for the filter
    @cities = Listing.distinct.pluck(:city).compact.sort
    @states = Listing.distinct.pluck(:state).compact.sort
    
    @listings = @listings.page(params[:page]).per(12)
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