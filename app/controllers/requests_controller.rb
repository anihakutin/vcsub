class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :mark_as_fulfilled]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @requests = if user_signed_in? && params[:my_requests]
      # Show all of current user's requests regardless of status
      current_user.requests
    else
      # For public view, show open requests + user's pending + fulfilled requests
      base_query = Request.where(status: ['open', 'fulfilled'])
      if user_signed_in?
        base_query = base_query.or(Request.where(user: current_user, status: 'pending'))
      end
      base_query
    end

    # Apply status filter
    if params[:status].present?
      case params[:status]
      when 'fulfilled'
        @requests = @requests.where(status: 'fulfilled')
      when 'pending'
        @requests = user_signed_in? ? @requests.where(status: 'pending') : @requests.none
      when 'open'
        @requests = @requests.where(status: 'open')
      end
    else
      # Default to open when no status is specified
      @requests = @requests.where(status: 'open')
    end
    
    # Apply other filters and ordering
    @requests = @requests.order(created_at: :desc)
    @requests = @requests.where(city: params[:city]) if params[:city].present?
    @requests = @requests.where(state: params[:state]) if params[:state].present?
    @requests = @requests.where(category: params[:category]) if params[:category].present?
    @requests = @requests.where('budget >= ?', params[:min_budget]) if params[:min_budget].present?
    @requests = @requests.where('budget <= ?', params[:max_budget]) if params[:max_budget].present?
    
    # Get unique locations for filters
    @cities = Request.distinct.pluck(:city).compact.sort
    @states = Request.distinct.pluck(:state).compact.sort
    
    @requests = @requests.page(params[:page]).per(6)
  end

  def show
    @request.increment_views
  end

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.new(request_params)
    @request.status = 'pending' # Ensure new requests start as pending

    if @request.save
      redirect_to @request, notice: "Request created successfully! It will be reviewed and go live within the next couple of hours."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @request.update(request_params)
      redirect_to @request, notice: 'Request was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @request.destroy
    redirect_to requests_url, notice: 'Request was successfully removed.'
  end

  def mark_as_fulfilled
    @request.mark_as_fulfilled!
    redirect_to @request, notice: 'Request has been marked as fulfilled!'
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :description, :category, :budget,
                                  :city, :state, :zip_code)
  end
end 