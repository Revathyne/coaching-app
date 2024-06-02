class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.role
    when 'admin'
      redirect_to rails_admin_path
    when 'coach'
      redirect_to coach_dashboard_path
    when 'employee'
      if current_user.company.blank?
        flash[:alert] = I18n.t(:company_nil)
        sign_out current_user
        redirect_to new_user_session_path
      else
        redirect_to employee_coaching_path
      end
    else
      flash[:alert] = I18n.t(:invalid_role)
      sign_out current_user
      redirect_to new_user_session_path and return
    end
  end
end
