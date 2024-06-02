class EmployeeCoachingController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_employee_role

  def index
    @employee = current_user
    @company = @employee.company
    @coaching_programs = build_coaching_programs
  end

  private

  def build_coaching_programs
    @employee.employee_registrations.each_with_object([]) do |employee_registration, data|
      coaching_program = employee_registration.coaching_program

      data << {
        coaching_program_name: coaching_program.name,
        coaching_program_description: coaching_program.description,
        coach_name: employee_registration.coach.user.name
      }
    end
  end
end
