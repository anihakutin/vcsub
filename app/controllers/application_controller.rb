class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_profile_completion, unless: -> { params[:action] == 'destroy' }
  before_action :set_current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def check_profile_completion
    if user_signed_in? && 
       !current_user.profile_completed? && 
       controller_name != 'profiles'
      redirect_to edit_profile_path, notice: "Please complete your profile first"
    end
  end

  def set_current_user
    Current.user = current_user
  end
end 