class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_profile_completion

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  private

  def check_profile_completion
    if user_signed_in? && current_user.sign_in_count == 1 && 
       !current_user.profile_completed? && 
       controller_name != 'profiles'
      redirect_to edit_profile_path, notice: "Please complete your profile first"
    end
  end
end 