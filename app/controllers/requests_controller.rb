class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy, :mark_as_fulfilled]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @requests = Request.order(created_at: :desc)
    
    @requests = case params[:status]
                when 'fulfilled'
                  @requests.fulfilled
                else
                  @requests.open
                end

    # Apply filters if present
    @requests = @requests.where(city: params[:city]) if params[:city].present?
    @requests = @requests.where(state: params[:state]) if params[:state].present?
    @requests = @requests.where(category: params[:category]) if params[:category].present?
    @requests = @requests.where('budget >= ?', params[:min_budget]) if params[:min_budget].present?
    @requests = @requests.where('budget <= ?', params[:max_budget]) if params[:max_budget].present?
    
    # Get unique values for filters
    @cities = Request.distinct.pluck(:city).compact.sort

    @requests = @requests.page(params[:page]).per(12)
  end

  def show
    @request.increment_views
  end

  def new
    @request = Request.new
  end

  def create
    @request = current_user.requests.build(request_params)

    if @request.save
      redirect_to @request, notice: 'Request was successfully posted!'
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