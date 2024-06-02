class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def ensure_employee_role
    redirect_to root_path unless current_user.role == 'employee'
  end

  def ensure_coach_role
    redirect_to root_path unless current_user.role == 'coach'
  end
end
