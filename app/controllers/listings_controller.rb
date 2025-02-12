class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :mark_as_sold]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = Listing.order(created_at: :desc)
    
    # Filter by status
    @listings = case params[:status]
                when 'sold'
                  @listings.sold
                else
                  @listings.available
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
    @listing = current_user.listings.build(listing_params)

    if @listing.save
      redirect_to @listing, notice: 'Your fire sale item has been listed!'
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