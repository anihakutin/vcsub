class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = Listing.order(created_at: :desc)
    
    # Apply filters if present
    @listings = @listings.where(city: params[:city]) if params[:city].present?
    @listings = @listings.where(state: params[:state]) if params[:state].present?
    @listings = @listings.where(zip_code: params[:zip_code]) if params[:zip_code].present?
    
    # Get unique cities for the filter
    @cities = Listing.distinct.pluck(:city).compact.sort
    @states = Listing.distinct.pluck(:state).compact.sort
    
    @listings = @listings.page(params[:page]).per(12)
  end

  def show
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
      # Attach any new images
      if params[:listing][:images].present?
        @listing.images.attach(params[:listing][:images])
      end
      redirect_to @listing, notice: 'Listing was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_url, notice: 'Listing was successfully removed.'
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
      :initial_valuation,
      :runway_end_date,
      :city,
      :state,
      :zip_code,
      images: []
    )
  end
end 