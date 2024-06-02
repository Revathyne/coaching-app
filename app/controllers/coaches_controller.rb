class CoachesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_coach_role

  def index
    @coach = Coach.find_by(user_id: current_user.id)
    @coaching_programs = @coach.coaching_programs.distinct
    @companies = Company.where(id: @coach.coaching_programs.pluck(:company_id))
    @employee_registrations = @coach.employee_registrations.includes(:user, :coaching_program)
  end

  def filter_sessions
    @coach = Coach.find_by(user_id: current_user.id)
    @employee_registrations = @coach.employee_registrations.includes(:user, :coaching_program)

    if params[:company_id].present?
      coaching_program = CoachingProgram.find_by(company_id: params[:company_id])
      @employee_registrations = @employee_registrations.where(coaching_program_id: coaching_program.id)
    end

    if params[:coaching_program_id].present?
      @employee_registrations = @employee_registrations.where(coaching_program_id: params[:coaching_program_id])
    end

    render partial: 'sessions_list', locals: { employee_registrations: @employee_registrations }
  end
end
