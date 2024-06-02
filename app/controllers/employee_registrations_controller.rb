class EmployeeRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_employee_role

  def new
    @employee = current_user
    @company = @employee.company
    @coaching_programs = @company.coaching_programs
  end

  def get_coaches
    program = CoachingProgram.find(params[:coaching_program_id])
    @coaches = program.coaches

    render json: build_coach_data
  end

  def create
    @user_id = current_user.id
    if registration_exists
      respond_to do |format|
        format.html { redirect_to employee_coaching_path, notice: I18n.t(:registered) }
        format.json { render json: { redirect: employee_coaching_path, notice: I18n.t(:registered) }, status: :ok }
      end
    else
      @employee_reg = EmployeeRegistration.new(coaching_program_id: employee_params[:coaching_program_id],
                                               coach_id: employee_params[:coach_id], user_id: @user_id)
      if @employee_reg.save
        current_user.update!(phone: employee_params[:phone], address: employee_params[:address])
        respond_to do |format|
          format.html { redirect_to employee_coaching_path, notice: I18n.t(:registration_success) }
          format.json { render json: { redirect: employee_coaching_path, notice: I18n.t(:registration_success) }, status: :ok }
        end
      else
        respond_to do |format|
          format.html do
            flash[:alert] = I18n.t(:failed_registration)
            redirect_to new_employee_registration_path
          end
          format.json { render json: { redirect: new_employee_registration_path, alert: I18n.t(:failed_registration) }, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def employee_params
    params.permit(:coaching_program_id, :phone, :coach_id, :address)
  end

  def build_coach_data
    @coaches.map do |coach|
      {
        id: coach.id,
        name: coach.user.name
      }
    end
  end

  def registration_exists
    EmployeeRegistration.exists?(coaching_program_id: employee_params[:coaching_program_id],
                                 coach_id: employee_params[:coach_id],
                                 user_id: @user_id)
  end
end
